package com.project.demo.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.*;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 供应信息：(SupplyInformation)表实体类
 *
 */
@TableName("`supply_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplyInformation implements Serializable {

    // SupplyInformation编号
    @TableId(value = "supply_infor_id", type = IdType.AUTO)
    private Integer supplyInforId;

    // 供应商名称
    @TableField(value = "`supplier_na`")
    private String supplierNa;
    // 供应商电话
    @TableField(value = "`suppliers_phone_number`")
    private String suppliersPhoneNumber;
    // 商品类别
    @TableField(value = "`comm_category`")
    private String commCategory;
    // 综合评价
    @TableField(value = "`compreh_eva`")
    private String comprehEva;
    // 供应频率
    @TableField(value = "`supply_freq`")
    private String supplyFreq;
    // 供应产品
    @TableField(value = "`supply_products`")
    private String supplyProducts;
    // 产品质量
    @TableField(value = "`product_quality`")
    private String productQuality;
    // 合作情况
    @TableField(value = "`cooperation_situ`")
    private String cooperationSitu;

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
