package com.project.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
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
    @TableId(value = "comm_infor_id", type = IdType.AUTO)
    private Integer commodityInformationId;
    // 商品编码
    @TableField(value = "`prod_code`")
    private String productCode;
    // 商品名称
    @TableField(value = "`prod_name`")
    private String productName;
    // 商品类别
    @TableField(value = "`prod_category`")
    private String productCategory;
    // 商品品牌
    @TableField(value = "`prod_brand`")
    private String productBrand;
    // 商品规格
    @TableField(value = "`comm_spec`")
    private String commoditySpecifications;
    // 商品库存
    @TableField(value = "`prod_inven`")
    private Double productInventory;
    // 商品图片
    @TableField(value = "`prod_ima`")
    private String productImages;
    // 商品价格
    @TableField(value = "`comm_price`")
    private Double commodityPrice;
    // 商品介绍
    @TableField(value = "`prod_intro`")
    private String productIntroduction;
    // 商品详情
    @TableField(value = "`product_details`")
    private String productDetails;

    // 点击数
    @TableField(value = "views")
    private Integer views;
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
    private String salesInformationLimitTimes;
    // 采购限制次数
    @TableField(value = "purchasing_information_limit_times")
    private String purchasingInformationLimitTimes;
    // 库存限制次数
    @TableField(value = "inventory_information_limit_times")
    private String inventoryInformationLimitTimes;

    // 是否删除
    @TableLogic
    @TableField(value = "is_delete")
    private Integer isDelete;

    // 版本号
    @Version
    @TableField(value = "version")
    private Integer version;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp updateTime;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp createTime;

}
