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
 * 库存信息：(InventoryInformation)表实体类
 *
 */
@TableName("`inventory_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class InventoryInformation implements Serializable {

    // InventoryInformation编号
    @TableId(value = "inventory_information_id", type = IdType.AUTO)
    private Integer inventory_information_id;

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
    // 商品库存
    @TableField(value = "`product_inventory`")
    private Double product_inventory;
    // 核对日期
    @TableField(value = "`check_date`")
    private String check_date;
    // 核对数量
    @TableField(value = "`check_quantity`")
    private Double check_quantity;
    // 库存情况
    @TableField(value = "`inventory`")
    private String inventory;




















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
