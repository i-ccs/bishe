package com.project.demo.constant;

/**
 * 查询配置常量类
 * 定义了查询、统计、分页等功能接口中使用的配置参数关键字
 * 该类中所有常量都是String类型，用于Map作为键
 * 
 * @author project
 * @version 1.0
 */
public class FindConfig {

    /** 查询请求中的分页页码参数关键字（默认1） */
    public static String PAGE = "page";

    /** 查询请求中每页记录数参数关键字 */
    public static String SIZE = "size";

    /** 查询请求中是否使用模糊查询的参数关键字（值为0表示精确查询，值为1表示模糊查询） */
    public static String LIKE = "like";

    /** 查询请求中指定排序字段的参数关键字（应当是数据库字段名） */
    public static String ORDER_BY = "orderby";

    /** 查询请求中指定查询字段的参数关键字（等同于SELECT子句） */
    public static String FIELD = "field";

    /** 查询请求中指定分组字段的参数关键字（等同于GROUP BY子句） */
    public static String GROUP_BY = "groupby";

    /** 查询请求中指定范围查询最小值的参数前缀（配合字段名使用，如age_min表示年龄>=某值） */
    public static String MIN_ = "_min";

    /** 查询请求中指定范围查询最大值的参数前缀（配合字段名使用，如age_max表示年龄<=某值） */
    public static String MAX_ = "_max";

    /** 查询请求中自定义SQL WHERE条件的参数关键字（应为SQL WHERE子句） */
    public static String SQLHWERE = "sqlwhere";
}
