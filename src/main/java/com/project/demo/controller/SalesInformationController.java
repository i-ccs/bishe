package com.project.demo.controller;

import com.project.demo.entity.SalesInformation;
import com.project.demo.service.SalesInformationService;
import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
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
        Map<String,Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        String sql = "SELECT MAX(sales_information_id) AS max FROM "+"`sales_information`";
        Integer max = service.selectBaseCount(sql);
        sql = ("SELECT count(*) count FROM `commodity_information` INNER JOIN `sales_information` ON commodity_information.product_code=sales_information.product_code WHERE commodity_information.product_inventory < sales_information.order_quantity AND sales_information.sales_information_id="+max).replaceAll("&#60;","<");
        Integer count = service.selectBaseCount(sql);
        if(count>0){
            sql = "delete from "+"sales_information"+" WHERE "+"sales_information_id"+" ="+max;
            service.deleteBaseSql(sql);
            return error(30000,"商品库存不足");
        }
        sql = "UPDATE `commodity_information` INNER JOIN `sales_information` ON commodity_information.product_code=sales_information.product_code SET commodity_information.product_inventory= commodity_information.product_inventory - sales_information.order_quantity WHERE sales_information.sales_information_id="+max;
        service.updateBaseSql(sql);
        return success(1);
    }


}
