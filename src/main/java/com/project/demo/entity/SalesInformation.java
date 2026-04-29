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
 * 销售信息：(SalesInformation)表实体类
 *
 */
@TableName("`sales_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class SalesInformation implements Serializable {

    // SalesInformation编号
    @TableId(value = "sales_information_id", type = IdType.AUTO)
    private Integer salesInformationId;

    // 商品编码
    @TableField(value = "product_code")
    private String productCode;
    // 商品名称
    @TableField(value = "product_name")
    private String productName;
    // 商品类别
    @TableField(value = "product_category")
    private String productCategory;
    // 商品品牌
    @TableField(value = "product_brand")
    private String productBrand;
    // 商品价格
    @TableField(value = "commodity_price")
    private Double commodityPrice;
    // 销售单号
    @TableField(value = "sales_order_number")
    private String salesOrderNumber;
    // 注册用户
    @TableField(value = "registered_user")
    private Integer registeredUser;
    // 用户姓名
    @TableField(value = "user_name")
    private String userName;
    // 下单数量
    @TableField(value = "order_quantity")
    private Double orderQuantity;
    // 订单总价
    @TableField(value = "total_order_price")
    private Double totalOrderPrice;
    // 备注信息
    @TableField(value = "note_information")
    private String noteInformation;

    // 支付状态
    @TableField(value = "pay_state")
    private String payState;

    // 支付类型: 微信、支付宝、网银
    @TableField(value = "pay_type")
    private String pay_type;

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
