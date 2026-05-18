package com.project.demo.controller;

import com.project.demo.entity.SupplyInformation;
import com.project.demo.service.SupplyInformationService;
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
 * 供应信息：(SupplyInformation)表控制层
 *
 */
@RestController
@RequestMapping("/supply_information")
public class SupplyInformationController extends BaseController<SupplyInformation, SupplyInformationService> {

    /**
     * 供应信息对象
     */
    @Autowired
    public SupplyInformationController(SupplyInformationService service) {
        setService(service);
    }

    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String, Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        return success(1);
    }

}
