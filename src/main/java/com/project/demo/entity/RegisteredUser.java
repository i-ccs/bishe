package com.project.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
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
    @TableField(value = "`user_name`")
    private String userName;
    // 用户性别
    @TableField(value = "`user_gender`")
    private Integer userGender;
    // 状态
    @TableField(value = "`state`")
    private Integer state;

    // 用户编号
    @TableField(value = "user_id")
    private Integer userId;

    // 审核状态
    @TableField(value = "examine_state")
    private String examineState;

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
