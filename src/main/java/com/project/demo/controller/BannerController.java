package com.project.demo.controller;

import com.project.demo.entity.Banner;
import com.project.demo.service.BannerService;

import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

/**
 * 轮播图：(Banner)表控制层
 *
 */
@RestController
@RequestMapping("banner")
public class BannerController extends BaseController<Banner, BannerService> {
    /**
     * 服务对象
     */
    @Autowired
    public BannerController(BannerService service) {
        setService(service);
    }

}


