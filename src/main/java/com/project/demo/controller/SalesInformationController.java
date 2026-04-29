package com.project.demo.controller;

import com.project.demo.entity.SalesInformation;
import com.project.demo.service.SalesInformationService;
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
 * 销售信息：(SalesInformation)表控制层
 *
 */
@RestController
@RequestMapping("/sales_information")
public class SalesInformationController extends BaseController<SalesInformation, SalesInformationService> {

    /**
     * 销售信息对象
     */
    @Autowired
    public SalesInformationController(SalesInformationService service) {
        setService(service);
    }

    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String, Object> paramMap = service.readBody(request.getReader());
        // 使用回填 id 的插入，避免并发问题
        Integer insertedId = service.insertReturnId(paramMap);
        if (insertedId == null) {
            this.addMap(paramMap);
            return success(1);
        }

        // 检查库存是否足够
        String checkSql = ("SELECT count(*) count FROM `merchandise_information` INNER JOIN `sales_information` ON merchandise_information.product_code=sales_information.product_code WHERE merchandise_information.product_inventory < sales_information.order_quantity AND sales_information.sales_information_id="
                + insertedId).replaceAll("&#60;", "<");
        Integer count = service.selectBaseCount(checkSql);
        if (count > 0) {
            String delSql = "delete from " + "sales_information" + " WHERE " + "sales_information_id" + " ="
                    + insertedId;
            service.deleteBaseSql(delSql);
            return error(30000, "商品库存不足");
        }

        // 读取必要字段并更新库存
        String productCode = paramMap.get("product_code") == null ? "" : paramMap.get("product_code").toString();
        double orderQuantity = 0.0;
        try {
            Object oq = paramMap.get("order_quantity");
            if (oq instanceof Number)
                orderQuantity = ((Number) oq).doubleValue();
            else if (oq != null)
                orderQuantity = Double.parseDouble(oq.toString());
        } catch (Exception e) {
            orderQuantity = 0.0;
        }

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
        double newInventory = oldInventory - orderQuantity;

        String updateSql = "UPDATE `merchandise_information` INNER JOIN `sales_information` ON merchandise_information.product_code=sales_information.product_code SET merchandise_information.product_inventory= merchandise_information.product_inventory - sales_information.order_quantity WHERE sales_information.sales_information_id="
                + insertedId;
        service.updateBaseSql(updateSql);

        return success(1);
    }

}
