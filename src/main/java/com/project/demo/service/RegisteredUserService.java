package com.project.demo.service;

import com.project.demo.entity.RegisteredUser;
import com.project.demo.service.base.BaseService;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.net.URLDecoder;
import com.project.demo.constant.FindConfig;

/**
 * 注册用户表服务类
 * 用于处理注册用户的数据查询、统计等业务逻辑
 * 主要功能包括：查询注册用户信息、统计记录数、分组统计等
 */
@Service
public class RegisteredUserService extends BaseService<RegisteredUser> {

    /**
     * 查询注册用户列表
     * 支持自定义字段、条件查询、排序、分组、分页等功能
     *
     * @param query  查询条件参数集合
     *               支持min_/max_前缀用于范围查询
     * @param config 配置参数集合，包含：
     *               - FIELD: 查询的字段列表
     *               - LIKE: 是否使用模糊查询
     *               - SQLHWERE: 自定义SQL条件
     *               - GROUP_BY: 分组字段
     *               - ORDER_BY: 排序字段
     *               - PAGE: 分页页码
     *               - SIZE: 分页大小
     * @return 组装完成的SQL查询语句
     */
    @Override
    public String select(Map<String, String> query, Map<String, String> config) {
        // 初始化SQL语句，构建SELECT子句
        StringBuffer sql = new StringBuffer("select ");
        // 如果未指定查询字段，则使用默认字段（注册用户字段+用户信息关键字段）
        sql.append(config.get(FindConfig.FIELD) == null || "".equals(config.get(FindConfig.FIELD))
                ? "a.*, b.user_id, b.nick_name, b.user_group, b.email, b.avatar"
                : config.get(FindConfig.FIELD)).append(" ");
        // 构建FROM和JOIN子句，关联注册用户表和用户表
        sql.append("from `registered_user` a ");
        sql.append("left join `user` b on a.user_name = b.user_name ");
        // 添加WHERE条件
        sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        // 添加GROUP BY子句用于分组（如果指定）
        if (config.get(FindConfig.GROUP_BY) != null && !"".equals(config.get(FindConfig.GROUP_BY))) {
            sql.append("group by a.").append(config.get(FindConfig.GROUP_BY)).append(" ");
        }
        // 添加ORDER BY子句用于排序（如果指定）
        if (config.get(FindConfig.ORDER_BY) != null && !"".equals(config.get(FindConfig.ORDER_BY))) {
            sql.append("order by a.").append(config.get(FindConfig.ORDER_BY)).append(" ");
        }
        // 添加LIMIT子句用于分页（如果指定页码）
        if (config.get(FindConfig.PAGE) != null && !"".equals(config.get(FindConfig.PAGE))) {
            int page = config.get(FindConfig.PAGE) != null && !"".equals(config.get(FindConfig.PAGE))
                    ? Integer.parseInt(config.get(FindConfig.PAGE))
                    : 1;
            int limit = config.get(FindConfig.SIZE) != null && !"".equals(config.get(FindConfig.SIZE))
                    ? Integer.parseInt(config.get(FindConfig.SIZE))
                    : 10;
            sql.append(" limit ").append((page - 1) * limit).append(" , ").append(limit);
        }
        return sql.toString();
    }

    /**
     * 统计符合条件的注册用户记录数
     * 支持分组计数和整体计数
     *
     * @param query  查询条件参数集合
     * @param config 配置参数集合，包含：
     *               - GROUP_BY: 分组字段
     *               - LIKE: 是否使用模糊查询
     *               - SQLHWERE: 自定义SQL条件
     * @return 组装完成的SQL计数语句
     */
    @Override
    public String count(Map<String, String> query, Map<String, String> config) {
        // 初始化COUNT统计SQL语句
        StringBuffer sql = new StringBuffer("SELECT ");
        // 如果指定了分组字段，则进行分组计数
        if (config.get(FindConfig.GROUP_BY) != null && !"".equals(config.get(FindConfig.GROUP_BY))) {
            sql.append("COUNT(a.").append(config.get(FindConfig.GROUP_BY)).append(") FROM `registered_user` a ");
            sql.append("left join `user` b on a.user_name = b.user_name ");
            sql.append(
                    toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        } else {
            // 否则进行整体计数
            sql.append("COUNT(*) FROM `registered_user` a ");
            sql.append("left join `user` b on a.user_name = b.user_name ");
            sql.append(
                    toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        }
        return sql.toString();
    }

    /**
     * 构建自定义WHERE条件语句
     * 支持精确查询、模糊查询、范围查询以及自定义SQL条件
     * 特殊处理：对user_id字段自动添加表别名b.
     *
     * @param query    查询条件参数集合
     *                 - 支持min_前缀表示范围下限
     *                 - 支持max_前缀表示范围上限
     * @param like     是否使用模糊查询（LIKE）
     * @param sqlwhere 自定义的SQL WHERE条件
     * @return 组装完成的WHERE条件语句
     */
    private String toWhereSqlCustom(Map<String, String> query, Boolean like, String sqlwhere) {
        StringBuilder sql = new StringBuilder();
        // 如果存在查询条件，则构建WHERE子句
        if (query.size() > 0) {
            try {
                sql.append(" WHERE ");
                // 遍历查询条件，逐个构建WHERE条件
                for (Map.Entry<String, String> entry : query.entrySet()) {
                    String field = humpToLine(entry.getKey());
                    // 判断字段所属表：用户表相关字段属于b表，其他字段属于a表
                    String alias = "a.";
                    if (field.equals("user_id") || field.equals("user_group") || field.equals("nick_name")
                            || field.equals("email")) {
                        alias = "b.";
                    }
                    // 处理范围查询：最小值条件（>=）
                    if (entry.getKey().contains(FindConfig.MIN_)) {
                        String min = humpToLine(entry.getKey()).replace("_min", "");
                        sql.append(alias).append("`").append(min).append("` >= '")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                        continue;
                    }
                    // 处理范围查询：最大值条件（<=）
                    if (entry.getKey().contains(FindConfig.MAX_)) {
                        String max = humpToLine(entry.getKey()).replace("_max", "");
                        sql.append(alias).append("`").append(max).append("` <= '")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                        continue;
                    }
                    // 根据配置选择模糊查询或精确查询
                    if (like) {
                        sql.append(alias).append("`").append(field).append("` LIKE '%")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("%' and ");
                    } else {
                        sql.append(alias).append("`").append(field).append("` = '")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                    }
                }
                // 添加自定义SQL条件并处理user_id字段的表别名
                if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                    // Deal with raw sqlwhere ambiguity. If it has user_id, make it b.user_id.
                    String finalSqlWhere = sqlwhere.replace("`user_id`", "b.`user_id`").replace("user_id", "b.user_id");
                    sql.append(finalSqlWhere).append(" and ");
                }
                // 移除最后的" and "连接符
                sql.delete(sql.length() - 4, sql.length());
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 如果没有查询条件，但有自定义SQL条件，则直接添加
            if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                // 处理user_id字段的表别名
                String finalSqlWhere = sqlwhere.replace("`user_id`", "b.`user_id`").replace("user_id", "b.user_id");
                sql.append(" WHERE ").append(finalSqlWhere);
            }
        }

        // 添加逻辑删除条件，确保只查询未删除的数据
        // 同时检查注册用户表和用户表的删除标记
        if (sql.length() == 0) {
            sql.append(" WHERE a.is_delete = 0 AND b.is_delete = 0 ");
        } else {
            sql.append(" AND a.is_delete = 0 AND b.is_delete = 0 ");
        }
        return sql.toString();
    }
}
