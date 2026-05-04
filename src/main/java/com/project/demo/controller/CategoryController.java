package com.project.demo.controller;

import com.project.demo.entity.Category;
import com.project.demo.service.CategoryService;

import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

/**
 * 文章频道：用于汇总浏览文章，在不同频道下展示不同文章。(Category)表控制层
 *
 */
@RestController
@RequestMapping("category")
public class CategoryController extends BaseController<Category, CategoryService> {
    /**
     * 服务对象
     */
    @Autowired
    public CategoryController(CategoryService service) {
        setService(service);
    }

}


