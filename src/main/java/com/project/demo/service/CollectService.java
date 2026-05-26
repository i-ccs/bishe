package com.project.demo.service;

import com.project.demo.entity.Collect;
import com.project.demo.service.base.BaseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 收藏：(Collect)表服务接口
 *
 */
@Slf4j
@Service
public class CollectService extends BaseService<Collect> {

    /**
     * 添加收藏并累加商品收藏数
     */
    @Override
    @Transactional
    public void insert(Map<String, Object> body) {
        // 调用父类插入收藏
        super.insert(body);

        // 拦截 SQL：处理收藏数累加
        if (body.containsKey("source_table") && body.containsKey("source_id") && body.containsKey("source_field")) {
            String sourceTable = (String) body.get("source_table");
            Object sourceIdObj = body.get("source_id");
            String sourceField = (String) body.get("source_field");

            if (sourceIdObj != null && !sourceIdObj.toString().isEmpty()) {
                Integer sourceId = Integer.valueOf(sourceIdObj.toString());
                String sql = "UPDATE `" + sourceTable + "` SET `collect_len` = `collect_len` + 1 WHERE `" + sourceField
                        + "` = " + sourceId;
                updateBaseSql(sql);
                log.info("[收藏累加] - 更新 {}.collect_len，sourceId={}", sourceTable, sourceId);
            }
        }
    }

    /**
     * 删除收藏并递减商品收藏数
     */
    @Override
    @Transactional
    public void delete(Map<String, String> query, Map<String, String> config) {
        // 先查询被删除的收藏记录，获取计数信息
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
                String sql = "UPDATE `" + sourceTable + "` SET `collect_len` = `collect_len` - 1 WHERE `" + sourceField
                        + "` = " + sourceId + " AND `collect_len` > 0";
                updateBaseSql(sql);
                log.info("[收藏递减] - 更新 {}.collect_len，sourceId={}", sourceTable, sourceId);
            }
        }
    }
}
