package com.project.demo.controller;

import com.project.demo.entity.AccessToken;
import com.project.demo.entity.PurchasingInformation;
import com.project.demo.entity.User;
import com.project.demo.service.PurchasingInformationService;
import com.project.demo.service.UserService;
import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
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

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private UserService userService;

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
        if (paramMap.get("procurement_status") == null || "".equals(paramMap.get("procurement_status").toString())) {
            paramMap.put("procurement_status", "待审批");
        }
        if (paramMap.get("source_user_id") == null || "".equals(paramMap.get("source_user_id").toString())) {
            Integer currentUserId = currentUserId(request);
            if (currentUserId != null) {
                paramMap.put("source_user_id", currentUserId);
            }
        }
        service.insertReturnId(paramMap);
        return success(1);
    }

    @PostMapping("/approve")
    @Transactional
    public Map<String, Object> approve(HttpServletRequest request) throws IOException {
        if (!"管理员".equals(currentUserGroup(request))) {
            return error(30000, "只有管理员可以审批采购单");
        }

        Map<String, Object> paramMap = service.readBody(request.getReader());
        Object idObj = paramMap.get("purchasing_information_id");
        if (idObj == null || "".equals(idObj.toString())) {
            return error(30000, "缺少采购单ID");
        }
        Integer purchasingInformationId = Integer.parseInt(idObj.toString());

        String selectSql = "SELECT * FROM `purchasing_information` WHERE purchasing_information_id="
                + purchasingInformationId;
        List<Map<String, Object>> list = service.selectMapBaseList(selectSql);
        if (list.size() == 0) {
            return error(30000, "采购单不存在");
        }
        Map<String, Object> row = list.get(0);
        String status = row.get("procurement_status") == null ? "" : row.get("procurement_status").toString();
        if ("已审批".equals(status)) {
            return success(1);
        }

        String productCode = row.get("product_code") == null ? "" : row.get("product_code").toString();
        String productName = row.get("product_name") == null ? "" : row.get("product_name").toString();
        String productCategory = row.get("product_category") == null ? "" : row.get("product_category").toString();
        String productBrand = row.get("product_brand") == null ? "" : row.get("product_brand").toString();
        double purchaseQuantity = row.get("purchase_quantity") == null ? 0.0
                : Double.parseDouble(row.get("purchase_quantity").toString());
        Integer sourceUserId = row.get("source_user_id") == null ? null
                : Integer.parseInt(row.get("source_user_id").toString());

        String inventorySql = "SELECT product_inventory FROM `merchandise_information` WHERE product_code='"
                + productCode.replace("'", "\\'") + "'";
        List<Map<String, Object>> inventoryList = service.selectMapBaseList(inventorySql);
        double oldInventory = 0.0;
        if (inventoryList.size() > 0 && inventoryList.get(0).get("product_inventory") != null) {
            oldInventory = Double.parseDouble(inventoryList.get(0).get("product_inventory").toString());
        }
        double newInventory = oldInventory + purchaseQuantity;

        service.updateBaseSql(
                "UPDATE `purchasing_information` SET procurement_status='已审批' WHERE purchasing_information_id="
                        + purchasingInformationId);
        service.updateBaseSql("UPDATE `merchandise_information` SET product_inventory = product_inventory + "
                + purchaseQuantity + " WHERE product_code='" + productCode.replace("'", "\\'") + "'");

        String checkDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
        String insertInv = "INSERT INTO `inventory_information` (`product_code`,`product_name`,`product_category`,`product_brand`,`product_inventory`,`check_date`,`check_quantity`,`inventory`,`source_table`,`source_id`,`source_user_id`,`create_time`,`update_time`) VALUES ('"
                + productCode.replace("'", "\\'") + "','" + productName.replace("'", "\\'") + "','"
                + productCategory.replace("'", "\\'") + "','" + productBrand.replace("'", "\\'") + "'," + newInventory
                + ", '" + checkDate + "'," + purchaseQuantity + ", '采购入库', 'purchasing_information', "
                + purchasingInformationId + ", " + (sourceUserId == null ? "NULL" : sourceUserId) + ", now(), now())";
        service.updateBaseSql(insertInv);

        return success(1);
    }

    private Integer currentUserId(HttpServletRequest request) {
        try {
            String token = request.getHeader("x-auth-token");
            if (token == null || "".equals(token)) {
                return null;
            }
            AccessToken accessToken = (AccessToken) redisTemplate.opsForValue().get(token);
            return accessToken == null ? null : accessToken.getUserId();
        } catch (Exception e) {
            return null;
        }
    }

    private String currentUserGroup(HttpServletRequest request) {
        Integer userId = currentUserId(request);
        if (userId == null) {
            return "";
        }
        List<Map<String, Object>> list = userService
                .selectMapBaseList("SELECT user_group FROM `user` WHERE user_id=" + userId);
        if (list.size() == 0 || list.get(0).get("user_group") == null) {
            return "";
        }
        return list.get(0).get("user_group").toString();
    }

}
