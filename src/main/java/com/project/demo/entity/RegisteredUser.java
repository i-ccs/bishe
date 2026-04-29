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
 * 注册用户：(RegisteredUser)表实体类
 *
 */
@TableName("`registered_user`")
@Data
@EqualsAndHashCode(callSuper = false)
public class RegisteredUser implements Serializable {

    // RegisteredUser编号
    @TableId(value = "registered_user_id", type = IdType.AUTO)
    private Integer registeredUserId;

    // 用户姓名
    @TableField(value = "user_name")
    private String userName;
    // 用户性别
    @TableField(value = "user_gender")
    private String userGender;

    // 审核状态
    @TableField(value = "examine_state")
    private String examineState;

    // 用户编号
    @TableField(value = "user_id")
    private Integer userId;

    // 更新时间
    @TableField(value = "update_time")
    private Timestamp updateTime;

    // 创建时间
    @TableField(value = "createTime")
    private Timestamp createTime;

}
