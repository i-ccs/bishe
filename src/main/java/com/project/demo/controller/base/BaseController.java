package com.project.demo.controller.base;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.project.demo.service.base.BaseService;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import jakarta.persistence.Query;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基础控制器类
 * 提供通用的CRUD操作和工具方法
 */
@Slf4j
public class BaseController<E, S extends BaseService<E>> {

    @Setter
    protected S service;

    /**
     * 添加记录
     * 
     * @param request HTTP请求对象
     * @return 操作结果
     * @throws IOException IO异常
     */
    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        service.insert(service.readBody(request.getReader()));
        return success(1);
    }

    /**
     * 通过Map添加记录
     * 
     * @param map 数据Map
     * @return 操作结果
     */
    @Transactional
    public Map<String, Object> addMap(Map<String, Object> map) {
        service.insert(map);
        return success(1);
    }

    /**
     * 更新记录
     * 
     * @param request HTTP请求对象
     * @return 操作结果
     * @throws IOException IO异常
     */
    @PostMapping("/set")
    @Transactional
    public Map<String, Object> set(HttpServletRequest request) throws IOException {
        service.update(service.readQuery(request), service.readConfig(request), service.readBody(request.getReader()));
        return success(1);
    }

    /**
     * 删除记录
     * 
     * @param request HTTP请求对象
     * @return 操作结果
     */
    @RequestMapping(value = "/del")
    @Transactional
    public Map<String, Object> del(HttpServletRequest request) {
        service.delete(service.readQuery(request), service.readConfig(request));
        return success(1);
    }

    /**
     * 获取单个对象
     * 
     * @param request HTTP请求对象
     * @return 查询结果对象
     */
    @RequestMapping("/get_obj")
    public Map<String, Object> obj(HttpServletRequest request) {
        List resultList = service
                .selectBaseList(service.select(service.readQuery(request), service.readConfig(request)));
        if (resultList.size() > 0) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("obj", resultList.get(0));
            return success(jsonObject);
        } else {
            return success(null);
        }
    }

    /**
     * 获取列表（分页）
     * 
     * @param request HTTP请求对象
     * @return 分页列表数据
     */
    @RequestMapping("/get_list")
    public Map<String, Object> getList(HttpServletRequest request) {
        Map<String, Object> map = service.selectToPage(service.readQuery(request), service.readConfig(request));
        return success(map);
    }

    /**
     * 分组列表查询
     * 
     * @param request HTTP请求对象
     * @return 分组列表数据
     */
    @RequestMapping("/list_group")
    public Map<String, Object> listGroup(HttpServletRequest request) {
        Map<String, Object> map = service.selectToList(service.readQuery(request), service.readConfig(request));
        Map<String, Object> result = new HashMap<>();
        result.put("result", map);
        return result;
    }

    /**
     * 柱状图分组统计
     * 
     * @param request HTTP请求对象
     * @return 柱状图统计数据
     */
    @RequestMapping("/bar_group")
    public Map<String, Object> barGroup(HttpServletRequest request) {
        Map<String, Object> map = service.selectBarGroup(service.readQuery(request), service.readConfig(request));
        return success(map);
    }

    /**
     * 分组计数或总数统计
     * 
     * @param request HTTP请求对象
     * @return 统计数量
     */
    @RequestMapping(value = { "/count_group", "/count" })
    public Map<String, Object> count(HttpServletRequest request) {
        Integer value = service
                .selectSqlToInteger(service.groupCount(service.readQuery(request), service.readConfig(request)));
        return success(value);
    }

    /**
     * 分组求和或总和统计
     * 
     * @param request HTTP请求对象
     * @return 求和结果
     */
    @RequestMapping(value = { "/sum_group", "/sum" })
    public Map<String, Object> sum(HttpServletRequest request) {
        Integer value = service
                .selectSqlToInteger(service.sum(service.readQuery(request), service.readConfig(request)));
        return success(value);
    }

    /**
     * 分组平均值或平均值统计
     * 
     * @param request HTTP请求对象
     * @return 平均值结果
     */
    @RequestMapping(value = { "/avg_group", "/avg" })
    public Map<String, Object> avg(HttpServletRequest request) {
        Integer value = service
                .selectSqlToInteger(service.avg(service.readQuery(request), service.readConfig(request)));
        return success(value);
    }

    /**
     * 文件上传
     * 
     * @param file 上传的文件
     * @return 上传结果，包含文件访问URL
     */
    @PostMapping("/upload")
    public Map<String, Object> upload(@RequestParam("file") MultipartFile file) {
        log.info("进入方法");
        if (file.isEmpty()) {
            return error(30000, "没有选择文件");
        }
        try {
            String filePath = System.getProperty("user.dir") + "/src/main/resources/static/";
            File targetDir = new File(filePath);
            if (!targetDir.exists() && !targetDir.isDirectory()) {
                if (targetDir.mkdirs()) {
                    log.info("创建目录成功");
                } else {
                    log.error("创建目录失败");
                }
            }
            String fileName = file.getOriginalFilename();
            File dest = new File(filePath + fileName);
            log.info("文件路径:{}", dest.getPath());
            log.info("文件名:{}", dest.getName());
            file.transferTo(dest);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("url", "/api/upload/" + fileName);
            return success(jsonObject);
        } catch (IOException e) {
            log.info("上传失败：{}", e.getMessage());
        }
        return error(30000, "上传失败");
    }

    /**
     * 成功响应
     * 
     * @param o 响应数据
     * @return 成功响应Map
     */
    public Map<String, Object> success(Object o) {
        Map<String, Object> map = new HashMap<>();
        if (o == null) {
            map.put("result", null);
            return map;
        }
        if (o instanceof List) {
            if (((List) o).size() == 1) {
                o = ((List) o).get(0);
                map.put("result", o);
            } else {
                String jsonString = JSONObject.toJSONString(o, SerializerFeature.WriteMapNullValue);
                JSONArray objects = service.covertArray(JSONObject.parseArray(jsonString));
                map.put("result", objects);
            }
        } else if (o instanceof Integer || o instanceof String) {
            map.put("result", o);
        } else {
            String jsonString = JSONObject.toJSONString(o, SerializerFeature.WriteMapNullValue);
            JSONObject jsonObject = JSONObject.parseObject(jsonString);
            JSONObject j = service.covertObject(jsonObject);
            map.put("result", j);
        }
        return map;
    }

    /**
     * 错误响应
     * 
     * @param code    错误码
     * @param message 错误消息
     * @return 错误响应Map
     */
    public Map<String, Object> error(Integer code, String message) {
        Map<String, Object> map = new HashMap<>();
        map.put("error", new HashMap<String, Object>(4) {
            {
                put("code", code);
                put("message", message);
            }
        });
        return map;
    }
}