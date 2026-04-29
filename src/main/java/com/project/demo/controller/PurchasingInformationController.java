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
public class PurchasingInformationController extends BaseController<PurchasingInformation, PurchasingInformationService> {

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
        Map<String,Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        String sql = "SELECT MAX(purchasing_information_id) AS max FROM "+"`purchasing_information`";
        Integer max = service.selectBaseCount(sql);
        sql = "UPDATE `merchandise_information` INNER JOIN `purchasing_information` ON merchandise_information.product_code=purchasing_information.product_code SET merchandise_information.product_inventory= merchandise_information.product_inventory + purchasing_information.purchase_quantity WHERE purchasing_information.purchasing_information_id="+max;
        service.updateBaseSql(sql);
        return success(1);
    }


}
