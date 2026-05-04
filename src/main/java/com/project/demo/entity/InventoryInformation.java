package com.project.demo.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.*;
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
    private Integer inventoryInformationId;

    // 商品编码
    @TableField(value = "`product_code`")
    private String productCode;
    // 商品名称
    @TableField(exist = false)
    private String productName;
    // 商品类别
    @TableField(exist = false)
    private String productCategory;
    // 商品品牌
    @TableField(exist = false)
    private String productBrand;
    // 商品库存
    @TableField(value = "`product_inventory`")
    private Double productInventory;
    // 核对日期
    @TableField(value = "`check_date`")
    private String checkDate;
    // 核对数量
    @TableField(value = "`check_quantity`")
    private Double checkQuantity;
    // 库存情况
    @TableField(value = "`inventory`")
    private String inventory;

    // 来源表
    @TableField(value = "source_table")
    private String sourceTable;

    // 来源ID
    @TableField(value = "source_id")
    private Integer sourceId;

    // 来源用户ID
    @TableField(value = "source_user_id")
    private Integer sourceUserIsd;

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
