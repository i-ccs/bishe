package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.Announcement;

import java.util.List;

/**
 * 公告：Mapper接口
 *
 */
public interface AnnouncementMapper extends BaseMapper<Announcement> {
    /**
     * 查询公告：
     *
     * @param announcementId 公告：ID
     * @return 公告：
     */
    Announcement selectAnnouncementById(Integer announcementId);

    /**
     * 查询公告：列表
     *
     * @param announcement 公告：
     * @return 公告：集合
     */
    List<Announcement> selectAnnouncementList(Announcement announcement);

    /**
     * 新增公告：
     *
     * @param announcement 公告：
     * @return 结果
     */
    int insertAnnouncement(Announcement announcement);

    /**
     * 修改公告：
     *
     * @param announcement 公告：
     * @return 结果
     */
    int updateAnnouncement(Announcement announcement);

    /**
     * 删除公告：
     *
     * @param announcementId 公告：ID
     * @return 结果
     */
    int deleteAnnouncementById(Integer announcementId);

    /**
     * 批量删除公告：
     *
     * @param announcementIds 需要删除的数据ID
     * @return 结果
     */
    int deleteAnnouncementByIds(Integer[] announcementIds);
}
