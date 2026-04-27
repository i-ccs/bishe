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
    private Integer purchasing_information_id;

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
    // 商品价格
    @TableField(value = "`commodity_price`")
    private Double commodity_price;
    // 采购单号
    @TableField(value = "`purchase_order_number`")
    private String purchase_order_number;
    // 供应商名称
    @TableField(value = "`supplier_name`")
    private String supplier_name;
    // 采购日期
    @TableField(value = "`purchase_date`")
    private String purchase_date;
    // 采购数量
    @TableField(value = "`purchase_quantity`")
    private Double purchase_quantity;
    // 采购单价
    @TableField(value = "`purchase_unit_price`")
    private Double purchase_unit_price;
    // 采购总价
    @TableField(value = "`total_purchase_price`")
    private Double total_purchase_price;
    // 采购情况
    @TableField(value = "`procurement_status`")
    private String procurement_status;




















			// 来源表
	@TableField(value = "source_table")
	private String source_table;
	
	// 来源ID
	@TableField(value = "source_id")
	private Integer source_id;
	
	// 来源用户ID
	@TableField(value = "source_user_id")
	private Integer source_user_id;
		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
