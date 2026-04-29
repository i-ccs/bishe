package com.project.demo.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 商品信息：(CommodityInformation)表实体类
 *
 */
@TableName("`commodity_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class CommodityInformation implements Serializable {

    // CommodityInformation编号
    @TableId(value = "commodity_information_id", type = IdType.AUTO)
    private Integer commodity_information_id;
    // 商品编码
    @TableField(value = "`product_code`")
    private String product_code;
    // 商品名称
    @TableField(value = "`product_name`")
    private String product_name;
    // 商品类别
    @TableField(value = "`product_category`")
    private String product_category;
    // 商品品牌
    @TableField(value = "`product_brand`")
    private String product_brand;
    // 商品规格
    @TableField(value = "`commodity_specifications`")
    private String commodity_specifications;
    // 商品库存
    @TableField(value = "`product_inventory`")
    private Double product_inventory;
    // 商品图片
    @TableField(value = "`product_images`")
    private String product_images;
    // 商品价格
    @TableField(value = "`commodity_price`")
    private Double commodity_price;
    // 商品介绍
    @TableField(value = "`product_introduction`")
    private String product_introduction;
    // 商品详情
    @TableField(value = "`product_details`")
    private String product_details;

    // 点击数
    @TableField(value = "hits")
    private Integer hits;
    // 点赞数
    @TableField(value = "praise_len")
    private Integer praise_len;

    // 收藏数
    @TableField(value = "collect_len")
    private Integer collect_len;

    // 评论数
    @TableField(value = "comment_len")
    private Integer comment_len;

    // 销售限制次数
    @TableField(value = "sales_information_limit_times")
    private Integer sales_information_limit_times;
    // 采购限制次数
    @TableField(value = "purchasing_information_limit_times")
    private Integer purchasing_information_limit_times;
    // 库存限制次数
    @TableField(value = "inventory_information_limit_times")
    private Integer inventory_information_limit_times;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
