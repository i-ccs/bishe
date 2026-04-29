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
    private Integer supply_information_id;

    // 供应商名称
    @TableField(value = "`supplier_name`")
    private String supplier_name;
    // 供应商电话
    @TableField(value = "`suppliers_phone_number`")
    private String suppliers_phone_number;
    // 商品类别
    @TableField(value = "`commodity_category`")
    private String commodity_category;
    // 综合评价
    @TableField(value = "`comprehensive_evaluation`")
    private String comprehensive_evaluation;
    // 供应频率
    @TableField(value = "`supply_frequency`")
    private String supply_frequency;
    // 供应产品
    @TableField(value = "`supply_products`")
    private String supply_products;
    // 产品质量
    @TableField(value = "`product_quality`")
    private String product_quality;
    // 合作情况
    @TableField(value = "`cooperation_situation`")
    private String cooperation_situation;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
