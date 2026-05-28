package com.project.demo.controller;

import com.project.demo.entity.PurchasingInformation;
import com.project.demo.service.PurchasingInformationService;
import com.project.demo.controller.base.BaseController;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

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
    public PurchasingInformationController(PurchasingInformationService service) {
        setService(service);
    }

    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String, Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        String sql = "SELECT MAX(purch_inf_id) AS max FROM " + "`purchasing_information`";
        Integer max = service.selectBaseCount(sql);
        sql = "UPDATE `commodity_information` INNER JOIN `purchasing_information` ON commodity_information.prod_code=purchasing_information.prod_code SET commodity_information.prod_inven= commodity_information.prod_inven + purchasing_information.purch_quantity WHERE purchasing_information.purch_inf_id="
                + max;
        service.updateBaseSql(sql);
        return success(1);
    }

}
