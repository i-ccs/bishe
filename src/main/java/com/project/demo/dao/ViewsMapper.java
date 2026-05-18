package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.Views;

import java.util.List;

/**
 * 【请填写功能名称】Mapper接口
 *
 */
public interface ViewsMapper extends BaseMapper<Views> {
    /**
     * 查询【请填写功能名称】
     *
     * @param viewsId 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    Views selectViewsById(Integer viewsId);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param views 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    List<Views> selectViewsList(Views views);

    /**
     * 新增【请填写功能名称】
     *
     * @param views 【请填写功能名称】
     * @return 结果
     */
    int insertViews(Views views);

    /**
     * 修改【请填写功能名称】
     *
     * @param views 【请填写功能名称】
     * @return 结果
     */
    int updateViews(Views views);

    /**
     * 删除【请填写功能名称】
     *
     * @param viewsId 【请填写功能名称】ID
     * @return 结果
     */
    int deleteViewsById(Integer viewsId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param viewsIds 需要删除的数据ID
     * @return 结果
     */
    int deleteViewsByIds(Integer[] viewsIds);
}
