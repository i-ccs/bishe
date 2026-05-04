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
 * 采购信息：(PurchasingInformation)表实体类
 *
 */
@TableName("`purchasing_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class PurchasingInformation implements Serializable {

    // PurchasingInformation编号
    @TableId(value = "purchasing_information_id", type = IdType.AUTO)
    private Integer purchasingInformationId;

    // 商品编码
    @TableField(value = "`product_code`")
    private String productCode;
    // 商品名称
    @TableField(value = "`product_name`")
    private String productName;
    // 商品类别
    @TableField(value = "`product_category`")
    private String productCategory;
    // 商品品牌
    @TableField(value = "`product_brand`")
    private String productBrand;
    // 商品规格
    @TableField(value = "`commodity_specifications`")
    private String commoditySpecifications;
    // 商品价格
    @TableField(value = "`commodity_price`")
    private Double commodityPrice;
    // 采购单号
    @TableField(value = "`purchase_order_number`")
    private String purchaseOrderNumber;
    // 供应商名称
    @TableField(value = "`supplier_name`")
    private String supplierName;
    // 采购日期
    @TableField(value = "`purchase_date`")
    private String purchaseDate;
    // 采购数量
    @TableField(value = "`purchase_quantity`")
    private Double purchaseQuantity;
    // 采购单价
    @TableField(value = "`purchase_unit_price`")
    private Double purchaseUnitPrice;
    // 采购总价
    @TableField(value = "`total_purchase_price`")
    private Double totalPurchasePrice;
    // 采购情况
    @TableField(value = "`procurement_status`")
    private String procurementStatus;

    // 来源表
    @TableField(value = "source_table")
    private String sourceTable;

    // 来源ID
    @TableField(value = "source_id")
    private Integer sourceId;

    // 来源用户ID
    @TableField(value = "source_user_id")
    private Integer sourceUserId;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp updateTime;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp createTime;

}
