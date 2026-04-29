package com.project.demo.controller;

import com.project.demo.entity.PurchasingInformation;
import com.project.demo.service.PurchasingInformationService;
import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import jakarta.persistence.Query;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.*;

/**
 * 采购信息：(PurchasingInformation)表控制层
 *
 */
@RestController
@RequestMapping("/purchasing_information")
public class PurchasingInformationController
        extends BaseController<PurchasingInformation, PurchasingInformationService> {

    /**
     * 采购信息对象
     */
    @Autowired
    public PurchasingInformationController(PurchasingInformationService service) {
        setService(service);
    }

    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String, Object> paramMap = service.readBody(request.getReader());
        // 使用可回填 id 的插入，避免并发使用 MAX()
        Integer insertedId = service.insertReturnId(paramMap);
        if (insertedId == null) {
            // 退回兼容行为：尝试老逻辑（不推荐）
            this.addMap(paramMap);
            return success(1);
        }

        // 读取必要字段并更新库存
        String productCode = paramMap.get("product_code") == null ? "" : paramMap.get("product_code").toString();
        double purchaseQuantity = 0.0;
        try {
            Object pq = paramMap.get("purchase_quantity");
            if (pq instanceof Number)
                purchaseQuantity = ((Number) pq).doubleValue();
            else if (pq != null)
                purchaseQuantity = Double.parseDouble(pq.toString());
        } catch (Exception e) {
            purchaseQuantity = 0.0;
        }

        // 读取旧库存
        String selSql = "SELECT product_inventory FROM `merchandise_information` WHERE product_code='"
                + productCode.replace("'", "\\'") + "'";
        List<Map<String, Object>> rows = service.selectMapBaseList(selSql);
        double oldInventory = 0.0;
        if (rows.size() > 0 && rows.get(0).get("product_inventory") != null) {
            try {
                oldInventory = Double.parseDouble(rows.get(0).get("product_inventory").toString());
            } catch (Exception ignored) {
            }
        }
        double newInventory = oldInventory + purchaseQuantity;

        String updateSql = "UPDATE `merchandise_information` INNER JOIN `purchasing_information` ON merchandise_information.product_code=purchasing_information.product_code SET merchandise_information.product_inventory= merchandise_information.product_inventory + purchasing_information.purchase_quantity WHERE purchasing_information.purchasing_information_id="
                + insertedId;
        service.updateBaseSql(updateSql);

        // 插入一条 inventory_information 日志
        String productName = paramMap.get("product_name") == null ? ""
                : paramMap.get("product_name").toString().replace("'", "\\'");
        String productCategory = paramMap.get("product_category") == null ? ""
                : paramMap.get("product_category").toString().replace("'", "\\'");
        String productBrand = paramMap.get("product_brand") == null ? ""
                : paramMap.get("product_brand").toString().replace("'", "\\'");
        String checkDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        String insertInv = "INSERT INTO `inventory_information` (`product_code`,`product_name`,`product_category`,`product_brand`,`product_inventory`,`check_date`,`check_quantity`,`inventory`,`source_table`,`source_id`,`source_user_id`,`create_time`,`update_time`) VALUES ('"
                + productCode.replace("'", "\\'") + "','" + productName + "','" + productCategory + "','" + productBrand
                + "'," + newInventory + ", '" + checkDate + "'," + purchaseQuantity
                + ", '采购入库', 'purchasing_information', " + insertedId + ", "
                + (paramMap.get("source_user_id") == null ? "NULL" : paramMap.get("source_user_id").toString())
                + ", now(), now())";
        service.updateBaseSql(insertInv);

        return success(1);
    }

}
