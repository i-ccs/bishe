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
    @TableId(value = "invent_info_id", type = IdType.AUTO)
    private Integer inventInfoId;

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
    // 商品库存
    @TableField(value = "`prod_invent`")
    private Double prodInvent;
    // 核对日期
    @TableField(value = "`check_date`")
    private String checkDate;
    // 核对数量
    @TableField(value = "`check_quant`")
    private Double checkQuant;
    // 库存情况
    @TableField(value = "`inventory`")
    private String inventory;

    // 来源表
    @TableField(value = "sou_table")
    private String souTable;

    // 来源ID
    @TableField(value = "sou_id")
    private Integer souId;

    // 来源用户ID
    @TableField(value = "sou_user_id")
    private Integer souUserId;

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
