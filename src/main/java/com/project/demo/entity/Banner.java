package com.project.demo.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * 轮播图：(Banner)表实体类
 */
@TableName("banner")
@Data
@EqualsAndHashCode(callSuper = false)
public class Banner implements Serializable {

    private static final long serialVersionUID = -75647097161026943L;

    /**
     * 轮播图ID：
     */
    @TableId(value = "banner_id", type = IdType.AUTO)
    private Integer bannerId;

    /**
     * 标题：
     */
    @TableField(value = "title")
    private String title;

    /**
     * 内容：
     */
    @TableField(value = "content")
    private String content;

    /**
     * 链接：
     */
    @TableField(value = "url")
    private String url;

    /**
     * 轮播图：
     */
    @TableField(value = "img")
    private String img;

    /**
     * 点击量：
     */
    @TableField(value = "views")
    private Integer views;

    /**
     * 创建时间：
     */
    @TableField(value = "create_time")
    private Timestamp createTime;

    /**
     * 更新时间：
     */
    @TableField(value = "update_time")
    private Timestamp updateTime;

}

