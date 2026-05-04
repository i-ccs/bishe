package com.project.demo.controller;

import com.project.demo.controller.base.BaseController;
import com.project.demo.entity.Views;
import com.project.demo.service.ViewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 点赞：(Views)表控制层
 */
@RestController
@RequestMapping("views")
public class ViewsController extends BaseController<Views, ViewsService> {
    /**
     * 服务对象
     */
    @Autowired
    public ViewsController(ViewsService service) {
        setService(service);
    }

}


