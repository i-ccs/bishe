package com.project.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
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
    @TableId(value = "purch_inf_id", type = IdType.AUTO)
    private Integer purchInfId;

    // 商品编码
    @TableField(value = "`prod_code`")
    private String prodCode;
    // 商品名称
    @TableField(exist = false)
    private String productName;
    // 商品类别
    @TableField(exist = false)
    private String productCategory;
    // 商品品牌
    @TableField(exist = false)
    private String productBrand;
    // 商品规格
    @TableField(exist = false)
    private String commoditySpecifications;
    // 商品价格
    @TableField(value = "`comm_price`")
    private Double commPrice;
    // 采购单号
    @TableField(value = "`purch_order_number`")
    private String purchOrderNumber;
    // 供应商名称
    @TableField(value = "`supplier_name`")
    private String supplierName;
    // 采购日期
    @TableField(value = "`purch_date`")
    private String purchDate;
    // 采购数量
    @TableField(value = "`purch_quantity`")
    private Double purchQuantity;
    // 采购单价
    @TableField(value = "`purch_unit_price`")
    private Double purchUnitPrice;
    // 采购总价
    @TableField(value = "`total_purch_price`")
    private Double totalPurchPrice;
    // 采购情况
    @TableField(value = "`procur_status`")
    private String procurStatus;

    // 来源表
    @TableField(value = "sour_table")
    private String sourTable;

    // 来源ID
    @TableField(value = "sour_id")
    private Integer sourId;

    // 来源用户ID
    @TableField(value = "sour_user_id")
    private Integer sourUserId;

    // 是否删除
    @TableLogic
    @TableField(value = "is_delete")
    private Integer isDelete;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp updateTime;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp createTime;

}
