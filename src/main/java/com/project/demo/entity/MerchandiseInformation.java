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
 * 商品信息：(merchandiseInformation)表实体类
 *
 */
@TableName("`merchandise_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class MerchandiseInformation implements Serializable {

    // merchandiseInformation编号
    @TableId(value = "merchandise_information_id", type = IdType.AUTO)
    private Integer merchandiseInformationId;
    // 商品编码
    @TableField(value = "product_code")
    private String productCode;
    // 商品名称
    @TableField(value = "product_name")
    private String productName;
    // 商品类别
    @TableField(value = "product_category")
    private String productCategory;
    // 商品品牌
    @TableField(value = "product_brand")
    private String productBrand;
    // 商品规格
    @TableField(value = "merchandise_specifications")
    private String merchandiseSpecifications;
    // 商品库存
    @TableField(value = "product_inventory")
    private Double productInventory;
    // 商品图片
    @TableField(value = "product_images")
    private String productImages;
    // 商品价格
    @TableField(value = "merchandise_price")
    private Double merchandisePrice;
    // 商品介绍
    @TableField(value = "product_introduction")
    private String productIntroduction;
    // 商品详情
    @TableField(value = "product_details")
    private String productDetails;

    // 点击数
    @TableField(value = "hits")
    private Integer hits;
    // 点赞数
    @TableField(value = "praise_len")
    private Integer praiseLen;

    // 收藏数
    @TableField(value = "collect_len")
    private Integer collectLen;

    // 评论数
    @TableField(value = "comment_len")
    private Integer commentLen;

    // 销售限制次数
    @TableField(value = "sales_information_limit_times")
    private Integer salesInformationLimitTimes;
    // 采购限制次数
    @TableField(value = "purchasing_information_limit_times")
    private Integer purchasingInformationLimitTimes;
    // 库存限制次数
    @TableField(value = "inventory_information_limit_times")
    private Integer inventoryInformationLimitTimes;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp updateTime;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp createTime;

}
