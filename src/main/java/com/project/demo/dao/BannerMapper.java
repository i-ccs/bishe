package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.Banner;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 轮播图：Mapper接口
 *
 */
@Mapper
public interface BannerMapper extends BaseMapper<Banner>
{
    /**
     * 查询轮播图：
     *
     * @param bannerId 轮播图：ID
     * @return 轮播图：
     */
    Banner selectBannerById(Integer bannerId);

    /**
     * 查询轮播图：列表
     *
     * @param banner 轮播图：
     * @return 轮播图：集合
     */
    List<Banner> selectBannerList(Banner banner);

    /**
     * 新增轮播图：
     *
     * @param banner 轮播图：
     * @return 结果
     */
    int insertBanner(Banner banner);

    /**
     * 修改轮播图：
     *
     * @param banner 轮播图：
     * @return 结果
     */
    int updateBanner(Banner banner);

    /**
     * 删除轮播图：
     *
     * @param bannerId 轮播图：ID
     * @return 结果
     */
    int deleteBannerById(Integer bannerId);

    /**
     * 批量删除轮播图：
     *
     * @param bannerIds 需要删除的数据ID
     * @return 结果
     */
    int deleteBannerByIds(Integer[] bannerIds);
}
