package com.project.demo.service;

import com.project.demo.entity.InventoryInformation;
import com.project.demo.service.base.BaseService;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.net.URLDecoder;
import com.project.demo.constant.FindConfig;

/**
 * 库存信息：(InventoryInformation)表服务接口
 *
 */
@Service
public class InventoryInformationService extends BaseService<InventoryInformation> {

    @Override
    public String select(Map<String, String> query, Map<String, String> config) {
        StringBuffer sql = new StringBuffer("select ");
        sql.append(config.get(FindConfig.FIELD) == null || "".equals(config.get(FindConfig.FIELD)) ? "a.*, b.product_name, b.product_category, b.product_brand"
                : config.get(FindConfig.FIELD)).append(" ");
        sql.append("from `inventory_information` a ");
        sql.append("left join `commodity_information` b on a.source_table = 'commodity_information' and a.source_id = b.commodity_information_id ");
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
            sql.append("COUNT(a.").append(config.get(FindConfig.GROUP_BY)).append(") FROM `inventory_information` a ");
            sql.append("left join `commodity_information` b on a.source_table = 'commodity_information' and a.source_id = b.commodity_information_id ");
            sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        } else {
            sql.append("COUNT(*) FROM `inventory_information` a ");
            sql.append("left join `commodity_information` b on a.source_table = 'commodity_information' and a.source_id = b.commodity_information_id ");
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
                    if (field.equals("product_name") || field.equals("product_category") || field.equals("product_brand")) {
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
                    sql.append(sqlwhere).append(" and ");
                }
                sql.delete(sql.length() - 4, sql.length());
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                sql.append(" WHERE ").append(sqlwhere);
            }
        }
        
        if (sql.length() == 0) {
            sql.append(" WHERE a.is_delete = 0 ");
        } else {
            sql.append(" AND a.is_delete = 0 ");
        }
        return sql.toString();
    }
    @Override
    public String selectGroupCount(Map<String, String> query, Map<String, String> config) {
        StringBuffer sql = new StringBuffer("select COUNT(*) AS count, ");
        String groupBy = config.get(FindConfig.GROUP_BY);
        String selectGroupBy = "a." + groupBy;
        if (groupBy.equals("product_name") || groupBy.equals("product_category") || groupBy.equals("product_brand")) {
            selectGroupBy = "b." + groupBy;
        }
        sql.append(selectGroupBy).append(" as ").append(groupBy).append(" ");
        sql.append("from `inventory_information` a ");
        sql.append("left join `commodity_information` b on a.source_table = 'commodity_information' and a.source_id = b.commodity_information_id ");
        sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        if (groupBy != null && !"".equals(groupBy)) {
            sql.append("group by ").append(selectGroupBy).append(" ");
        }
        return sql.toString();
    }
}
