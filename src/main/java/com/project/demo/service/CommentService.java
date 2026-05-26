package com.project.demo.service;

import com.project.demo.entity.Comment;
import com.project.demo.service.base.BaseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 评论：(Comment)表服务接口
 *
 */
@Slf4j
@Service
public class CommentService extends BaseService<Comment> {

    /**
     * 添加评论并累加商品评论数
     */
    @Override
    @Transactional
    public void insert(Map<String, Object> body) {
        // 调用父类插入评论
        super.insert(body);

        // 拦截 SQL：处理评论数累加
        if (body.containsKey("source_table") && body.containsKey("source_id") && body.containsKey("source_field")) {
            String sourceTable = (String) body.get("source_table");
            Object sourceIdObj = body.get("source_id");
            String sourceField = (String) body.get("source_field");

            if (sourceIdObj != null && !sourceIdObj.toString().isEmpty()) {
                Integer sourceId = Integer.valueOf(sourceIdObj.toString());
                String sql = "UPDATE `" + sourceTable + "` SET `comment_len` = `comment_len` + 1 WHERE `" + sourceField
                        + "` = " + sourceId;
                updateBaseSql(sql);
                log.info("[评论累加] - 更新 {}.comment_len，sourceId={}", sourceTable, sourceId);
            }
        }
    }

    /**
     * 删除评论并递减商品评论数
     */
    @Override
    @Transactional
    public void delete(Map<String, String> query, Map<String, String> config) {
        // 先查询被删除的评论记录，获取计数信息
        List<Map<String, Object>> deleteRecords = selectMapBaseList(select(query, config));

        // 执行删除
        super.delete(query, config);

        // 递减计数字段
        for (Map<String, Object> record : deleteRecords) {
            String sourceTable = (String) record.get("source_table");
            Object sourceIdObj = record.get("source_id");
            String sourceField = (String) record.get("source_field");

            if (sourceTable != null && sourceIdObj != null && sourceField != null) {
                Integer sourceId = Integer.valueOf(sourceIdObj.toString());
                String sql = "UPDATE `" + sourceTable + "` SET `comment_len` = `comment_len` - 1 WHERE `" + sourceField
                        + "` = " + sourceId + " AND `comment_len` > 0";
                updateBaseSql(sql);
                log.info("[评论递减] - 更新 {}.comment_len，sourceId={}", sourceTable, sourceId);
            }
        }
    }
}
