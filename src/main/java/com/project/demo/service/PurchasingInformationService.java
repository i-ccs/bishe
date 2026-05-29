package com.project.demo.service;

import com.project.demo.entity.PurchasingInformation;
import com.project.demo.service.base.BaseService;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.net.URLDecoder;
import com.project.demo.constant.FindConfig;

/**
 * 采购信息表服务类
 * 用于处理采购信息的数据查询、统计等业务逻辑
 * 主要功能包括：查询采购信息、统计记录数、分组统计等
 */
@Service
public class PurchasingInformationService extends BaseService<PurchasingInformation> {

    /**
     * 查询采购信息列表
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
        // 如果未指定查询字段，则使用默认字段（采购信息字段+商品信息关键字段）
        sql.append(config.get(FindConfig.FIELD) == null || "".equals(config.get(FindConfig.FIELD))
                ? "a.*, b.prod_name as product_name, b.prod_category as product_category, b.prod_brand as product_brand, b.comm_spec as commodity_specifications"
                : config.get(FindConfig.FIELD)).append(" ");
        // 构建FROM和JOIN子句，关联采购信息表和商品信息表
        sql.append("from `purchasing_information` a ");
        sql.append(
                "left join `commodity_information` b on a.sour_table = 'commodity_information' and a.sour_id = b.comm_infor_id ");
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
     * 统计符合条件的采购信息记录数
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
            sql.append("COUNT(a.").append(config.get(FindConfig.GROUP_BY)).append(") FROM `purchasing_information` a ");
            sql.append(
                    "left join `commodity_information` b on a.sour_table = 'commodity_information' and a.sour_id = b.comm_infor_id ");
            sql.append(
                    toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        } else {
            // 否则进行整体计数
            sql.append("COUNT(*) FROM `purchasing_information` a ");
            sql.append(
                    "left join `commodity_information` b on a.sour_table = 'commodity_information' and a.sour_id = b.comm_infor_id ");
            sql.append(
                    toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        }
        return sql.toString();
    }

    /**
     * 构建自定义WHERE条件语句
     * 支持精确查询、模糊查询、范围查询以及自定义SQL条件
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
                    // 判断字段所属表：商品信息相关字段属于b表，其他字段属于a表
                    String alias = "a.";
                    String column = field;
                    if (field.equals("product_name") || field.equals("product_category")
                            || field.equals("product_brand") || field.equals("commodity_specifications")) {
                        alias = "b.";
                        column = field.equals("product_name") ? "prod_name"
                                : field.equals("product_category") ? "prod_category"
                                        : field.equals("product_brand") ? "prod_brand" : "comm_spec";
                    }
                    // 处理范围查询：最小值条件（>=）
                    if (entry.getKey().contains(FindConfig.MIN_)) {
                        String min = humpToLine(entry.getKey()).replace("_min", "");
                        if (alias.equals("b.")) {
                            min = min.equals("product_name") ? "prod_name"
                                    : min.equals("product_category") ? "prod_category"
                                            : min.equals("product_brand") ? "prod_brand" : "comm_spec";
                        }
                        sql.append(alias).append("`").append(min).append("` >= '")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                        continue;
                    }
                    // 处理范围查询：最大值条件（<=）
                    if (entry.getKey().contains(FindConfig.MAX_)) {
                        String max = humpToLine(entry.getKey()).replace("_max", "");
                        if (alias.equals("b.")) {
                            max = max.equals("product_name") ? "prod_name"
                                    : max.equals("product_category") ? "prod_category"
                                            : max.equals("product_brand") ? "prod_brand" : "comm_spec";
                        }
                        sql.append(alias).append("`").append(max).append("` <= '")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                        continue;
                    }
                    // 根据配置选择模糊查询或精确查询
                    if (like) {
                        sql.append(alias).append("`").append(column).append("` LIKE '%")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("%' and ");
                    } else {
                        sql.append(alias).append("`").append(column).append("` = '")
                                .append(URLDecoder.decode(entry.getValue(), "UTF-8")).append("' and ");
                    }
                }
                // 添加自定义SQL条件
                if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                    sql.append(sqlwhere).append(" and ");
                }
                // 移除最后的" and "连接符
                sql.delete(sql.length() - 4, sql.length());
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 如果没有查询条件，但有自定义SQL条件，则直接添加
            if (sqlwhere != null && !sqlwhere.trim().equals("")) {
                sql.append(" WHERE ").append(sqlwhere);
            }
        }

        // 添加逻辑删除条件，确保只查询未删除的数据
        if (sql.length() == 0) {
            sql.append(" WHERE a.is_delete = 0 ");
        } else {
            sql.append(" AND a.is_delete = 0 ");
        }
        return sql.toString();
    }

    /**
     * 查询分组后的采购信息统计数据
     * 用于获取按指定字段分组的采购统计信息，通常用于统计分析
     *
     * @param query  查询条件参数集合
     * @param config 配置参数集合，包含：
     *               - GROUP_BY: 必须指定的分组字段
     *               - LIKE: 是否使用模糊查询
     *               - SQLHWERE: 自定义SQL条件
     * @return 组装完成的分组统计SQL语句
     */
    @Override
    public String selectGroupCount(Map<String, String> query, Map<String, String> config) {
        // 初始化分组统计SQL语句
        StringBuffer sql = new StringBuffer("select COUNT(*) AS count, ");
        // 获取分组字段
        String groupBy = config.get(FindConfig.GROUP_BY);
        String selectGroupBy = groupBy;
        // 根据分组字段的类型和来源添加适当的表别名
        if (groupBy.equals("product_name") || groupBy.equals("product_category") || groupBy.equals("product_brand")
                || groupBy.equals("commodity_specifications")) {
            // 商品信息表字段，使用b表别名
            selectGroupBy = "b." + (groupBy.equals("product_name") ? "prod_name"
                    : groupBy.equals("product_category") ? "prod_category"
                            : groupBy.equals("product_brand") ? "prod_brand" : "comm_spec");
        } else if (groupBy.equals("DATE(create_time)")) {
            // 日期函数字段，指定为a表的create_time
            selectGroupBy = "DATE(a.create_time)";
        } else if (!groupBy.contains("(")) {
            // 采购信息表字段，使用a表别名
            selectGroupBy = "a." + groupBy;
        }
        // 构建SELECT子句
        sql.append(selectGroupBy).append(" as `").append(groupBy).append("` ");
        sql.append("from `purchasing_information` a ");
        sql.append(
                "left join `commodity_information` b on a.sour_table = 'commodity_information' and a.sour_id = b.comm_infor_id ");
        sql.append(toWhereSqlCustom(query, "0".equals(config.get(FindConfig.LIKE)), config.get(FindConfig.SQLHWERE)));
        // 添加GROUP BY子句
        if (groupBy != null && !"".equals(groupBy)) {
            sql.append("group by ").append(selectGroupBy).append(" ");
        }
        return sql.toString();
    }
}
