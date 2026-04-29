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
 * 供应信息：(SupplyInformation)表实体类
 *
 */
@TableName("`supply_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplyInformation implements Serializable {

    // SupplyInformation编号
    @TableId(value = "supply_information_id", type = IdType.AUTO)
    private Integer supplyInformationId;

    // 供应商名称
    @TableField(value = "supplier_name")
    private String supplierName;
    // 供应商电话
    @TableField(value = "suppliers_phone_number")
    private String suppliersPhoneNumber;
    // 商品类别
    @TableField(value = "commodity_category")
    private String commodityCategory;
    // 综合评价
    @TableField(value = "comprehensive_evaluation")
    private String comprehensiveEvaluation;
    // 供应频率
    @TableField(value = "supply_frequency")
    private String supplyFrequency;
    // 供应产品
    @TableField(value = "supply_products")
    private String supplyProducts;
    // 产品质量
    @TableField(value = "product_quality")
    private String productQuality;
    // 合作情况
    @TableField(value = "cooperation_situation")
    private String cooperationSituation;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp updateTime;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp createTime;

}
