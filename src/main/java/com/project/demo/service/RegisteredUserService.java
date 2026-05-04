package com.project.demo.service;

import com.project.demo.entity.RegisteredUser;
import com.project.demo.service.base.BaseService;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.net.URLDecoder;
import com.project.demo.constant.FindConfig;

/**
 * 注册用户：(RegisteredUser)表服务接口
 *
 */
@Service
public class RegisteredUserService extends BaseService<RegisteredUser> {

    @Override
    public String select(Map<String, String> query, Map<String, String> config) {
        StringBuffer sql = new StringBuffer("select ");
        sql.append(config.get(FindConfig.FIELD) == null || "".equals(config.get(FindConfig.FIELD)) ? "a.*, b.user_id, b.nick_name, b.user_group, b.email, b.avatar"
                : config.get(FindConfig.FIELD)).append(" ");
        sql.append("from `registered_user` a ");
        sql.append("left join `user` b on a.user_name = b.user_name ");
        sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        if (config.get(FindConfig.GROUP_BY) != null && !"".equals(config.get(FindConfig.GROUP_BY))) {
            sql.append("group by a.").append(config.get(FindConfig.GROUP_BY)).append(" ");
        }
        if (config.get(FindConfig.ORDER_BY) != null && !"".equals(config.get(FindConfig.ORDER_BY))) {
            sql.append("order by a.").append(config.get(FindConfig.ORDER_BY)).append(" ");
        }
        if (config.get(FindConfig.PAGE) != null && !"".equals(config.get(FindConfig.PAGE))) {
            int page = config.get(FindConfig.PAGE) != null && !"".equals(config.get(FindConfig.PAGE))
                    ? Integer.parseInt(config.get(FindConfig.PAGE)) : 1;
            int limit = config.get(FindConfig.SIZE) != null && !"".equals(config.get(FindConfig.SIZE))
                    ? Integer.parseInt(config.get(FindConfig.SIZE)) : 10;
            sql.append(" limit ").append((page - 1) * limit).append(" , ").append(limit);
        }
        return sql.toString();
    }

    @Override
    public String count(Map<String, String> query, Map<String, String> config) {
        StringBuffer sql = new StringBuffer("SELECT ");
        if (config.get(FindConfig.GROUP_BY) != null && !"".equals(config.get(FindConfig.GROUP_BY))) {
            sql.append("COUNT(a.").append(config.get(FindConfig.GROUP_BY)).append(") FROM `registered_user` a ");
            sql.append("left join `user` b on a.user_name = b.user_name ");
            sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        } else {
            sql.append("COUNT(*) FROM `registered_user` a ");
            sql.append("left join `user` b on a.user_name = b.user_name ");
            sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        }
        return sql.toString();
    }

    private String toWhereSqlCustom(Map<String, String> query, Boolean like, String sqlwhere) {
        StringBuilder sql = new StringBuilder();
        if (query.size() > 0) {
            try {
                sql.append(" WHERE ");
                for (Map.Entry<String, String> entry : query.entrySet()) {
                    String field = humpToLine(entry.getKey());
                    String alias = "a.";
                    if (field.equals("user_id") || field.equals("user_group") || field.equals("nick_name") || field.equals("email")) {
                        alias = "b.";
                    }
                    if (entry.getKey().contains(FindConfig.MIN_)) {
                        String min = humpToLine(entry.getKey()).replace("_min", "");
                        sql.append(alias).append("`").append(min).append("` >= '").append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                        continue;
                    }
                    if (entry.getKey().contains(FindConfig.MAX_)) {
                        String max = humpToLine(entry.getKey()).replace("_max", "");
                        sql.append(alias).append("`").append(max).append("` <= '").append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                        continue;
                    }
                    if (like) {
                        sql.append(alias).append("`").append(field).append("` LIKE '%").append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("%' and ");
                    } else {
                        sql.append(alias).append("`").append(field).append("` = '").append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                    }
                }
                if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                    // Deal with raw sqlwhere ambiguity. If it has user_id, make it b.user_id.
                    String finalSqlWhere = sqlwhere.replace("`user_id`", "b.`user_id`").replace("user_id", "b.user_id");
                    sql.append(finalSqlWhere).append(" and ");
                }
                sql.delete(sql.length() - 4, sql.length());
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                String finalSqlWhere = sqlwhere.replace("`user_id`", "b.`user_id`").replace("user_id", "b.user_id");
                sql.append(" WHERE ").append(finalSqlWhere);
            }
        }
        
        if (sql.length() == 0) {
            sql.append(" WHERE a.is_delete = 0 AND b.is_delete = 0 ");
        } else {
            sql.append(" AND a.is_delete = 0 AND b.is_delete = 0 ");
        }
        return sql.toString();
    }
}
