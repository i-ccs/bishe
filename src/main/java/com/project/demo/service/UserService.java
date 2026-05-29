package com.project.demo.service;

import com.project.demo.dao.UserMapper;
import com.project.demo.entity.User;
import com.project.demo.entity.UserGroup;
import com.project.demo.service.UserGroupService;
import com.project.demo.service.base.BaseService;
import com.project.demo.constant.FindConfig;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

/**
 * 用户账户：用于保存用户登录信息(User)表服务接口
 *
 */
@Service
public class UserService extends BaseService<User> {

    @Autowired
    UserMapper userMapper;

    @Autowired
    private UserGroupService userGroupService;

    public String selectExamineState(String sourceTable, Integer userId) {
        return userMapper.selectExamineState(sourceTable,userId);
    }

    @Override
    @Transactional
    public void delete(Map<String, String> query, Map<String, String> config) {
        // 1. 获取即将删除的用户列表
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        toWhereWrapper(query, "0".equals(config.get(FindConfig.GROUP_BY)), wrapper);
        List<User> usersToDelete = userMapper.selectList(wrapper);

        // 2. 调用父类的删除（逻辑删除）
        super.delete(query, config);

        // 3. 同步到对应的角色/分组附属表，将 is_delete 字段置为 1
        for (User user : usersToDelete) {
            if (user.getUserGroup() != null) {
                Map<String, String> groupQuery = new HashMap<>();
                groupQuery.put("name", user.getUserGroup());
                List<UserGroup> groups = userGroupService
                        .selectBaseList(userGroupService.select(groupQuery, new HashMap<>()));
                if (groups.size() > 0) {
                    UserGroup group = groups.get(0);
                    String sourceTable = group.getSourceTable();
                    if (sourceTable != null && !sourceTable.isEmpty()) {
                        String sql = "UPDATE `" + sourceTable + "` SET `is_delete` = 1 WHERE `user_id` = " + user.getUserId();
                        updateBaseSql(sql);
                    }
                }
            }
        }
    }
}


