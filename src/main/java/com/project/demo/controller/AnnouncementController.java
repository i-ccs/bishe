package com.project.demo.controller;

import com.project.demo.entity.Announcement;
import com.project.demo.service.AnnouncementService;

import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

/**
 * 公告：(Announcement)表控制层
 *
 */
@RestController
@RequestMapping("announcement")
public class AnnouncementController extends BaseController<Announcement, AnnouncementService> {
    /**
     * 服务对象
     */
    @Autowired
    public AnnouncementController(AnnouncementService service) {
        setService(service);
    }

}


