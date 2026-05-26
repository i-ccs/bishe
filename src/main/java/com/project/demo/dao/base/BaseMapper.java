package com.project.demo.dao.base;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BaseMapper<E> extends com.baomidou.mybatisplus.core.mapper.BaseMapper<E> {

    /**
     * 执行动态SQL查询，返回结果列表
     *
     * @param select 要执行的SELECT查询语句
     * @return 查询结果列表，每个元素为Map<String, Object>类型，key为字段名，value为字段值
     */
    List<Map<String, Object>> selectBaseList(@Param("select") String select);

    /**
     * 执行动态SQL计数查询
     *
     * @param count 要执行的COUNT查询语句
     * @return 符合条件的记录总数
     */
    Integer selectBaseCount(@Param("count") String count);

    /**
     * 执行动态SQL查询，返回单条记录
     *
     * @param select 要执行的SELECT查询语句
     * @return 查询结果，如果有多条记录则返回第一条，如果没有记录则返回null
     */
    Object selectBaseOne(@Param("select") String select);

    /**
     * 执行动态SQL更新操作
     *
     * @param sql 要执行的UPDATE SQL语句
     * @return 受影响的行数
     */
    int updateBaseSql(@Param("sql") String sql);

    /**
     * 执行动态SQL删除操作
     *
     * @param sql 要执行的DELETE SQL语句
     * @return 受影响的行数
     */
    int deleteBaseSql(@Param("sql") String sql);
}
