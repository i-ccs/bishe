/*
 Navicat Premium Dump SQL

 Source Server         : bao
 Source Server Type    : MySQL
 Source Server Version : 80409 (8.4.9)
 Source Host           : localhost:3306
 Source Schema         : store

 Target Server Type    : MySQL
 Target Server Version : 80409 (8.4.9)
 File Encoding         : 65001

 Date: 29/04/2026 22:03:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access_token
-- ----------------------------
DROP TABLE IF EXISTS `access_token`;
CREATE TABLE `access_token` (
  `token_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '临时访问牌ID',
  `token` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '临时访问牌',
  `info` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '信息',
  `max_age` int NOT NULL DEFAULT '2' COMMENT '最大寿命：默认2小时',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '用户编号',
  PRIMARY KEY (`token_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='登陆访问时长';

-- ----------------------------
-- Records of access_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` mediumint unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `title` varchar(125) NOT NULL DEFAULT '' COMMENT '标题',
  `type` varchar(64) NOT NULL DEFAULT '0' COMMENT '文章分类',
  `hits` int unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `praise_len` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source` varchar(255) DEFAULT NULL COMMENT '来源',
  `url` varchar(255) DEFAULT NULL COMMENT '来源地址',
  `tag` varchar(255) DEFAULT NULL COMMENT '标签',
  `content` longtext COMMENT '正文',
  `img` varchar(255) DEFAULT NULL COMMENT '封面图',
  `description` text COMMENT '文章描述',
  PRIMARY KEY (`article_id`,`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='文章';

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` (`article_id`, `title`, `type`, `hits`, `praise_len`, `create_time`, `update_time`, `source`, `url`, `tag`, `content`, `img`, `description`) VALUES (7, '2026年\"618\"大促预热开启，各大平台聚焦\"即时零售\"新赛道', '电商', 0, 0, '2026-04-28 22:56:47', '2026-04-28 22:56:47', '', '', '', '<p>随着年中购物季临近，京东、天猫、拼多多等主流电商平台陆续启动\"618\"预售活动。今年大促呈现三大新趋势：一是\"小时达\"即时零售成为核心战场，超2000个县区实现30分钟送达；二是AI导购全面升级，基于大模型的智能推荐显著提升转化率；三是绿色消费理念深入人心，平台纷纷推出以旧换新、碳积分奖励等可持续举措。业内专家预测，今年618全网成交额有望突破万亿，直播电商与内容种草将继续驱动增长新引擎。</p><p><br></p>', '/api/upload/1777388087.png', '');
COMMIT;

-- ----------------------------
-- Table structure for article_type
-- ----------------------------
DROP TABLE IF EXISTS `article_type`;
CREATE TABLE `article_type` (
  `type_id` smallint unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `display` smallint unsigned NOT NULL DEFAULT '100' COMMENT '显示顺序',
  `name` varchar(16) NOT NULL DEFAULT '' COMMENT '分类名称',
  `father_id` smallint unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `icon` text COMMENT '分类图标',
  `url` varchar(255) DEFAULT NULL COMMENT '外链地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='文章分类';

-- ----------------------------
-- Records of article_type
-- ----------------------------
BEGIN;
INSERT INTO `article_type` (`type_id`, `display`, `name`, `father_id`, `description`, `icon`, `url`, `create_time`, `update_time`) VALUES (2, 100, '电商', 0, '', '', '', '2026-04-28 22:51:12', '2026-04-28 22:51:12');
INSERT INTO `article_type` (`type_id`, `display`, `name`, `father_id`, `description`, `icon`, `url`, `create_time`, `update_time`) VALUES (3, 100, '商品', 0, '', '', '', '2026-04-28 22:51:23', '2026-04-28 22:51:23');
COMMIT;

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `auth_id` int NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `user_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户组',
  `mod_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模块名',
  `table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '表名',
  `page_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '页面标题',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由路径',
  `position` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '位置',
  `mode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '跳转方式',
  `add` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可增加',
  `del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可删除',
  `set` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可修改',
  `get` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可查看',
  `field_add` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '添加字段',
  `field_set` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '修改字段',
  `field_get` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '查询字段',
  `table_nav_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '跨表导航名称',
  `table_nav` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否跨表操作',
  `option` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '配置',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `parent` varchar(255) DEFAULT NULL COMMENT '父级',
  `parent_sort` int DEFAULT '0' COMMENT '父级排序',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='定制授权';

-- ----------------------------
-- Records of auth
-- ----------------------------
BEGIN;
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (417, '管理员', '注册用户管理', 'registered_user', '注册用户', '/registered_user/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:39:30', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (418, '管理员', '注册用户管理', 'registered_user', '注册用户', '/registered_user/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:39:33', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (421, '管理员', '商品信息', 'merchandise_information', '商品信息', '/merchandise_information/table', NULL, 'list', 1, 1, 1, 1, NULL, 'product_code,product_name,product_category,product_brand,merchandise_specifications,merchandise_price,product_introduction,product_details,product_code,product_name,product_category,product_brand,product_introduction,product_details,product_inventory,product_images,create_time,update_time', 'create_time,update_time,product_name,product_category,product_code,merchandise_specifications,product_inventory,product_images,merchandise_price,product_introduction,merchandiseInformationId,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times', NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-29 15:14:33', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (422, '管理员', '商品信息', 'merchandise_information', '商品信息', '/merchandise_information/view', NULL, 'view', 1, 1, 1, 1, 'product_code,product_name,product_category,product_brand,merchandise_specifications,merchandise_price,product_introduction,product_details,product_code,product_name,product_category,product_brand,product_introduction,product_details,product_inventory,product_images', 'product_code,product_name,product_category,product_brand,merchandise_specifications,merchandise_price,product_introduction,product_details,product_code,product_name,product_category,product_brand,product_introduction,product_details,product_inventory,product_images', 'product_code,product_name,product_category,product_brand,merchandise_specifications,merchandise_price,product_introduction,product_details,product_inventory,product_images', NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-29 15:25:22', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (423, '管理员', '供应信息', 'supply_information', '供应信息', '/supply_information/table', NULL, 'list', 1, 1, 1, 1, '', '1', '', NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 17:36:22', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (424, '管理员', '供应信息', 'supply_information', '供应信息', '/supply_information/view', NULL, 'view', 1, 1, 1, 1, '', '', 'supplier_name,supply_products,product_quality,suppliers_phone_number,commodity_category,comprehensive_evaluation,cooperation_situation,supply_frequency,supply_information_id', NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 16:42:40', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (425, '管理员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:39:50', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (426, '管理员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:39:53', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (427, '管理员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:39:56', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (428, '管理员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:01', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (429, '管理员', '销售信息', 'sales_information', '销售信息', '/sales_information/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:04', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (430, '管理员', '销售信息', 'sales_information', '销售信息', '/sales_information/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:07', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (431, '管理员', '资源', 'article', '文章资讯', '/article/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:10', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (432, '管理员', '资源', 'article', '文章资讯', '/article/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:13', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (433, '管理员', '资讯分类', 'article_type', '资讯分类', '/article_type/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:16', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (434, '管理员', '资讯分类', 'article_type', '资讯分类', '/article_type/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:40:19', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (435, '管理员', '评论', 'comment', '评论列表', '/comment/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:32:03', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (436, '管理员', '评论', 'comment', '评论详情', '/comment/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:32:00', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (437, '管理员', '系统公告', 'notice', '公告列表', '/notice/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:31:45', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (438, '管理员', '系统公告', 'notice', '公告详情', '/notice/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-04-27 15:31:48', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (445, '注册用户', '行业资讯', 'article', '资讯详情', '/article/details', NULL, 'view', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 17:06:06', '2026-04-27 17:06:06', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (446, '注册用户', '行业资讯', 'article', '资讯详情', '/article/list', NULL, 'view', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 17:22:30', '2026-04-27 17:22:30', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (447, '注册用户', '商品信息', 'commodity_information', '商品信息', '/merchandise_category/list', 'top', 'list', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 17:26:56', '2026-04-29 15:17:10', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (448, '注册用户', '商品信息', 'commodity_information', '商品详情', '/merchandise_category/details', NULL, 'view', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-27 17:26:56', '2026-04-29 15:17:13', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (449, '采购员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/table', NULL, 'list', 1, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 20:02:02', '2026-04-29 20:02:02', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (450, '采购员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/view', NULL, 'form', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 20:02:02', '2026-04-29 20:02:02', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (451, '采购员', '商品信息', 'merchandise_information', '商品信息', '/merchandise_information/table', 'top', 'list', 1, 1, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 20:02:02', '2026-04-29 21:55:47', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (452, '采购员', '商品信息', 'merchandise_information', '商品信息', '/merchandise_information/view', NULL, 'form', 1, 1, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 20:02:02', '2026-04-29 21:55:47', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (453, '采购员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/table', NULL, 'list', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 20:02:02', '2026-04-29 20:02:02', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (454, '采购员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/view', NULL, 'form', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 20:02:02', '2026-04-29 20:02:02', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (455, '采购员', '销售信息', 'sales_information', '销售信息', '/sales_information/table', NULL, 'list', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 21:55:47', '2026-04-29 21:55:47', NULL, 0);
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `option`, `create_time`, `update_time`, `parent`, `parent_sort`) VALUES (456, '采购员', '销售信息', 'sales_information', '销售信息', '/sales_information/view', NULL, 'view', 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, '2026-04-29 21:55:47', '2026-04-29 21:55:47', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for code_token
-- ----------------------------
DROP TABLE IF EXISTS `code_token`;
CREATE TABLE `code_token` (
  `code_token_id` int NOT NULL AUTO_INCREMENT COMMENT '验证码ID',
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT '令牌',
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT '验证码',
  `expire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '失效时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`code_token_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='验证码';

-- ----------------------------
-- Records of code_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `collect_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '收藏人ID',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '标题',
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '封面',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`collect_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='收藏';

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '评论人ID',
  `reply_to_id` int unsigned NOT NULL DEFAULT '0' COMMENT '回复评论ID',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '内容',
  `nick_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  PRIMARY KEY (`comment_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='评论';

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for hits
-- ----------------------------
DROP TABLE IF EXISTS `hits`;
CREATE TABLE `hits` (
  `hits_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '点赞人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  PRIMARY KEY (`hits_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户点击';

-- ----------------------------
-- Records of hits
-- ----------------------------
BEGIN;
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (1, 2, '2026-04-26 15:42:49', '2026-04-26 15:42:49', 'commodity_information', 'commodity_information_id', 10);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (2, 2, '2026-04-27 17:27:14', '2026-04-27 17:27:14', 'commodity_information', 'commodity_information_id', 1);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (3, 2, '2026-04-27 17:27:27', '2026-04-27 17:27:27', 'commodity_information', 'commodity_information_id', 2);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (4, 2, '2026-04-27 18:05:15', '2026-04-27 18:05:15', 'commodity_information', 'commodity_information_id', 2);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (5, 2, '2026-04-27 18:19:54', '2026-04-27 18:19:54', 'commodity_information', 'commodity_information_id', 2);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (6, 2, '2026-04-27 18:20:02', '2026-04-27 18:20:02', 'commodity_information', 'commodity_information_id', 19);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (7, 2, '2026-04-27 18:20:21', '2026-04-27 18:20:21', 'commodity_information', 'commodity_information_id', 18);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (8, 2, '2026-04-27 18:21:42', '2026-04-27 18:21:42', 'commodity_information', 'commodity_information_id', 18);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (9, 2, '2026-04-27 18:21:52', '2026-04-27 18:21:52', 'commodity_information', 'commodity_information_id', 20);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (10, 2, '2026-04-27 18:24:16', '2026-04-27 18:24:16', 'commodity_information', 'commodity_information_id', 20);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (11, 2, '2026-04-27 18:24:33', '2026-04-27 18:24:33', 'commodity_information', 'commodity_information_id', 14);
COMMIT;

-- ----------------------------
-- Table structure for inventory_information
-- ----------------------------
DROP TABLE IF EXISTS `inventory_information`;
CREATE TABLE `inventory_information` (
  `inventory_information_id` int NOT NULL AUTO_INCREMENT COMMENT '库存信息ID',
  `product_code` varchar(64) DEFAULT NULL COMMENT '商品编码',
  `product_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `product_category` varchar(64) DEFAULT NULL COMMENT '商品类别',
  `product_brand` varchar(64) DEFAULT NULL COMMENT '商品品牌',
  `product_inventory` double(8,2) DEFAULT '0.00' COMMENT '商品库存',
  `check_date` date DEFAULT NULL COMMENT '核对日期',
  `check_quantity` double(8,2) DEFAULT '0.00' COMMENT '核对数量',
  `inventory` text COMMENT '库存情况',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) DEFAULT NULL COMMENT '来源表',
  `source_id` int DEFAULT '0' COMMENT '来源ID',
  `source_user_id` int DEFAULT '0' COMMENT '来源用户',
  PRIMARY KEY (`inventory_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='库存信息';

-- ----------------------------
-- Records of inventory_information
-- ----------------------------
BEGIN;
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777389744267', '小王子', '书', '进口公司', 11.00, '2026-04-29', 5.00, '采购入库', '2026-04-29 16:55:15', '2026-04-29 16:55:15', 'purchasing_information', 14, 1);
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (14, '1777389744267', '小王子', '书', '进口公司', 10.00, '2026-04-29', 1.00, '销售出库', '2026-04-29 16:56:13', '2026-04-29 16:56:13', 'sales_information', 13, 1);
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (15, '1777389744267', '小王子', '书', '进口公司', 10.00, '2026-04-29', 10.00, '', '2026-04-29 17:00:52', '2026-04-29 17:00:52', 'merchandise_information', 21, 1);
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (16, '1777389744267', '小王子', '书', '进口公司', 13.00, '2026-04-29', 3.00, '采购入库', '2026-04-29 17:48:24', '2026-04-29 17:48:24', 'purchasing_information', 13, 1);
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (17, '1777389744267', '小王子', '书', '进口公司', 18.00, '2026-04-29', 5.00, '采购入库', '2026-04-29 17:49:03', '2026-04-29 17:49:03', 'purchasing_information', 14, 1);
COMMIT;

-- ----------------------------
-- Table structure for merchandise_information
-- ----------------------------
DROP TABLE IF EXISTS `merchandise_information`;
CREATE TABLE `merchandise_information` (
  `merchandise_information_id` int NOT NULL AUTO_INCREMENT COMMENT '商品信息ID',
  `product_code` varchar(64) DEFAULT NULL COMMENT '商品编码',
  `product_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `product_category` varchar(64) DEFAULT NULL COMMENT '商品类别',
  `product_brand` varchar(64) DEFAULT NULL COMMENT '商品品牌',
  `merchandise_specifications` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品规格',
  `product_inventory` double(8,2) DEFAULT '0.00' COMMENT '商品库存',
  `product_images` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `merchandise_price` double(8,2) DEFAULT '0.00' COMMENT '商品价格',
  `product_introduction` text COMMENT '商品介绍',
  `product_details` longtext COMMENT '商品详情',
  `hits` int NOT NULL DEFAULT '0' COMMENT '点击数',
  `praise_len` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `collect_len` int NOT NULL DEFAULT '0' COMMENT '收藏数',
  `comment_len` int NOT NULL DEFAULT '0' COMMENT '评论数',
  `sales_information_limit_times` int NOT NULL DEFAULT '0' COMMENT '销售限制次数',
  `purchasing_information_limit_times` int NOT NULL DEFAULT '0' COMMENT '采购限制次数',
  `inventory_information_limit_times` int NOT NULL DEFAULT '0' COMMENT '库存限制次数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`merchandise_information_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品信息';

-- ----------------------------
-- Records of merchandise_information
-- ----------------------------
BEGIN;
INSERT INTO `merchandise_information` (`merchandise_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `merchandise_specifications`, `product_inventory`, `product_images`, `merchandise_price`, `product_introduction`, `product_details`, `hits`, `praise_len`, `collect_len`, `comment_len`, `sales_information_limit_times`, `purchasing_information_limit_times`, `inventory_information_limit_times`, `create_time`, `update_time`) VALUES (21, '1777389744267', '小王子', '书', '进口公司', '200*100', 18.00, '/api/upload/forum_3.jpg', 3.00, '', '', 0, 0, 0, 0, 0, 0, 0, '2026-04-28 23:26:35', '2026-04-29 17:49:03');
COMMIT;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `notice_id` mediumint unsigned NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(125) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '正文',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='公告';

-- ----------------------------
-- Records of notice
-- ----------------------------
BEGIN;
INSERT INTO `notice` (`notice_id`, `title`, `content`, `create_time`, `update_time`) VALUES (1, '网站公告', '<p>公告，是指政府、团体对重大事件当众正式公布或者公开宣告，宣布。国务院2012年4月16日发布、2012年7月1日起施行的《党政机关公文处理工作条例》，对公告的使用表述为：“适用于向国内外宣布重要事项或者法定事项”。其中包含两方面的内容：一是向国内外宣布重要事项，公布依据政策、法令采取的重大行动等；二是向国内外宣布法定事项，公布依据法律规定告知国内外的有关重要规定和重大行动等。</p>', '2025-04-30 18:21:49', '2025-04-30 18:21:49');
INSERT INTO `notice` (`notice_id`, `title`, `content`, `create_time`, `update_time`) VALUES (2, '关于我们', '<p>       一个网站要取得成功，要有先进的理念、先进的思想，更为重要的是抢占先机，及时行动。网络世界可谓一日千里、 日新月异，一个网站只有把握先机，抓住机遇，才</p><p>可能有更多的机会获得成功，可能处于网络行业发展的致高点，可能创建出成功的网站，才能能获得成功。要知道一种网站新模式在网络上只有保持几天的优势,因为人们很容易“COPY\" 和模仿，因此，唯有不</p><p>断创新，不失时机地推出新的服务、新的模式、新的思想，网站才可能长久立于不败之地。</p>', '2025-04-30 18:21:49', '2025-04-30 18:21:49');
INSERT INTO `notice` (`notice_id`, `title`, `content`, `create_time`, `update_time`) VALUES (3, '联系方式', '<h3>网站内容及品牌合作</h3><p>Email：xxxx@qq.com</p><h3>商务合作</h3><p>电话：010-xxxxxxx</p><p>Email：xxxx@qq.com</p><h3><br></h3><h3><br></h3><p><br></p>', '2025-04-30 18:21:49', '2025-04-30 18:21:49');
INSERT INTO `notice` (`notice_id`, `title`, `content`, `create_time`, `update_time`) VALUES (4, '网站介绍', '<p>此处可上传文字、图片、视频、超链接、表格等内容区</p>', '2025-04-30 18:21:49', '2025-04-30 18:21:49');
COMMIT;

-- ----------------------------
-- Table structure for praise
-- ----------------------------
DROP TABLE IF EXISTS `praise`;
CREATE TABLE `praise` (
  `praise_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '点赞人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '点赞状态:1为点赞，0已取消',
  PRIMARY KEY (`praise_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `praise_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='点赞';

-- ----------------------------
-- Records of praise
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for purchasing_information
-- ----------------------------
DROP TABLE IF EXISTS `purchasing_information`;
CREATE TABLE `purchasing_information` (
  `purchasing_information_id` int NOT NULL AUTO_INCREMENT COMMENT '采购信息ID',
  `product_code` varchar(64) DEFAULT NULL COMMENT '商品编码',
  `product_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `product_category` varchar(64) DEFAULT NULL COMMENT '商品类别',
  `product_brand` varchar(64) DEFAULT NULL COMMENT '商品品牌',
  `merchandise_specifications` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品规格',
  `merchandise_price` double(8,2) DEFAULT '0.00' COMMENT '商品价格',
  `purchase_order_number` varchar(64) DEFAULT NULL COMMENT '采购单号',
  `supplier_name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `purchase_date` date DEFAULT NULL COMMENT '采购日期',
  `purchase_quantity` double(8,2) DEFAULT '0.00' COMMENT '采购数量',
  `purchase_unit_price` double(8,2) DEFAULT '0.00' COMMENT '采购单价',
  `total_purchase_price` double(8,2) DEFAULT '0.00' COMMENT '采购总价',
  `procurement_status` text COMMENT '采购情况',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) DEFAULT NULL COMMENT '来源表',
  `source_id` int DEFAULT '0' COMMENT '来源ID',
  `source_user_id` int DEFAULT '0' COMMENT '来源用户',
  PRIMARY KEY (`purchasing_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='采购信息';

-- ----------------------------
-- Records of purchasing_information
-- ----------------------------
BEGIN;
INSERT INTO `purchasing_information` (`purchasing_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `merchandise_specifications`, `merchandise_price`, `purchase_order_number`, `supplier_name`, `purchase_date`, `purchase_quantity`, `purchase_unit_price`, `total_purchase_price`, `procurement_status`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777389744267', '小王子', '书', '进口公司', '200*100', 3.00, '1777449610144', '米头', '2026-04-29', 3.00, 2.00, 6.00, '已审批', '2026-04-29 16:00:40', '2026-04-29 17:48:24', 'merchandise_information', 21, 1);
INSERT INTO `purchasing_information` (`purchasing_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `merchandise_specifications`, `merchandise_price`, `purchase_order_number`, `supplier_name`, `purchase_date`, `purchase_quantity`, `purchase_unit_price`, `total_purchase_price`, `procurement_status`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (14, '1777389744267', '小王子', '书', '进口公司', '200*100', 3.00, '1777452898716', '米头', '2026-04-29', 5.00, 2.00, 10.00, '已审批', '2026-04-29 16:55:15', '2026-04-29 17:49:03', 'merchandise_information', 21, 1);
COMMIT;

-- ----------------------------
-- Table structure for registered_user
-- ----------------------------
DROP TABLE IF EXISTS `registered_user`;
CREATE TABLE `registered_user` (
  `registered_user_id` int NOT NULL AUTO_INCREMENT COMMENT '注册用户ID',
  `user_name` varchar(64) DEFAULT NULL COMMENT '用户姓名',
  `user_gender` varchar(64) DEFAULT NULL COMMENT '用户性别',
  `examine_state` varchar(16) NOT NULL DEFAULT '已通过' COMMENT '审核状态',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`registered_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='注册用户';

-- ----------------------------
-- Records of registered_user
-- ----------------------------
BEGIN;
INSERT INTO `registered_user` (`registered_user_id`, `user_name`, `user_gender`, `examine_state`, `user_id`, `create_time`, `update_time`) VALUES (1, '王明', '男', '已通过', 2, '2025-05-18 11:51:27', '2026-04-29 18:48:43');
INSERT INTO `registered_user` (`registered_user_id`, `user_name`, `user_gender`, `examine_state`, `user_id`, `create_time`, `update_time`) VALUES (2, '用户姓名2', '女', '已通过', 3, '2025-05-18 11:51:27', '2026-04-27 14:15:38');
COMMIT;

-- ----------------------------
-- Table structure for sales_information
-- ----------------------------
DROP TABLE IF EXISTS `sales_information`;
CREATE TABLE `sales_information` (
  `sales_information_id` int NOT NULL AUTO_INCREMENT COMMENT '销售信息ID',
  `product_code` varchar(64) DEFAULT NULL COMMENT '商品编码',
  `product_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `product_category` varchar(64) DEFAULT NULL COMMENT '商品类别',
  `product_brand` varchar(64) DEFAULT NULL COMMENT '商品品牌',
  `merchandise_price` double(8,2) DEFAULT '0.00' COMMENT '商品价格',
  `sales_order_number` varchar(64) DEFAULT NULL COMMENT '销售单号',
  `registered_user` int DEFAULT '0' COMMENT '注册用户',
  `user_name` varchar(64) DEFAULT NULL COMMENT '用户姓名',
  `order_quantity` double(8,2) DEFAULT '0.00' COMMENT '下单数量',
  `total_order_price` double(8,2) DEFAULT '0.00' COMMENT '订单总价',
  `note_information` text COMMENT '备注信息',
  `pay_state` varchar(16) NOT NULL DEFAULT '未支付' COMMENT '支付状态',
  `pay_type` varchar(16) DEFAULT '' COMMENT '支付类型: 微信、支付宝、网银',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) DEFAULT NULL COMMENT '来源表',
  `source_id` int DEFAULT '0' COMMENT '来源ID',
  `source_user_id` int DEFAULT '0' COMMENT '来源用户',
  PRIMARY KEY (`sales_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='销售信息';

-- ----------------------------
-- Records of sales_information
-- ----------------------------
BEGIN;
INSERT INTO `sales_information` (`sales_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `merchandise_price`, `sales_order_number`, `registered_user`, `user_name`, `order_quantity`, `total_order_price`, `note_information`, `pay_state`, `pay_type`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777389744267', '小王子', '书', '进口公司', 3.00, '1777452964751', 2, '李刚', 1.00, 3.00, '', '未支付', '', '2026-04-29 16:56:13', '2026-04-29 16:57:01', 'merchandise_information', 21, 1);
COMMIT;

-- ----------------------------
-- Table structure for slides
-- ----------------------------
DROP TABLE IF EXISTS `slides`;
CREATE TABLE `slides` (
  `slides_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '内容',
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '链接',
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '轮播图',
  `hits` int unsigned NOT NULL DEFAULT '0' COMMENT '点击量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`slides_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='轮播图';

-- ----------------------------
-- Records of slides
-- ----------------------------
BEGIN;
INSERT INTO `slides` (`slides_id`, `title`, `content`, `url`, `img`, `hits`, `create_time`, `update_time`) VALUES (4, '鞋子', '', '/article/details?article=1', '/api/upload/O1CN01ZRrBML2E2FBnUwKS6_!!0-item_pic.jpg_460x460q90.jpg_.webp', 0, '2026-04-27 18:31:29', '2026-04-27 18:35:01');
COMMIT;

-- ----------------------------
-- Table structure for supply_information
-- ----------------------------
DROP TABLE IF EXISTS `supply_information`;
CREATE TABLE `supply_information` (
  `supply_information_id` int NOT NULL AUTO_INCREMENT COMMENT '供应信息ID',
  `supplier_name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `suppliers_phone_number` varchar(16) DEFAULT NULL COMMENT '供应商电话',
  `merchandise_category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品类别',
  `comprehensive_evaluation` varchar(64) DEFAULT NULL COMMENT '综合评价',
  `supply_frequency` varchar(64) DEFAULT NULL COMMENT '供应频率',
  `supply_products` text COMMENT '供应产品',
  `product_quality` text COMMENT '产品质量',
  `cooperation_situation` text COMMENT '合作情况',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`supply_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='供应信息';

-- ----------------------------
-- Records of supply_information
-- ----------------------------
BEGIN;
INSERT INTO `supply_information` (`supply_information_id`, `supplier_name`, `suppliers_phone_number`, `merchandise_category`, `comprehensive_evaluation`, `supply_frequency`, `supply_products`, `product_quality`, `cooperation_situation`, `create_time`, `update_time`) VALUES (15, '米头', '18523651234', '书', '好', '一周一次', '小王子', '', '', '2026-04-29 11:41:19', '2026-04-29 11:41:19');
COMMIT;

-- ----------------------------
-- Table structure for upload
-- ----------------------------
DROP TABLE IF EXISTS `upload`;
CREATE TABLE `upload` (
  `upload_id` int NOT NULL AUTO_INCREMENT COMMENT '上传ID',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件名',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '访问路径',
  `file` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件路径',
  `display` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '显示顺序',
  `father_id` int DEFAULT '0' COMMENT '父级ID',
  `dir` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件夹',
  `type` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件类型',
  PRIMARY KEY (`upload_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='文件上传';

-- ----------------------------
-- Records of upload
-- ----------------------------
BEGIN;
INSERT INTO `upload` (`upload_id`, `name`, `path`, `file`, `display`, `father_id`, `dir`, `type`) VALUES (1, 'movie.mp4', '/upload/movie.mp4', '', NULL, 0, NULL, 'video');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `state` smallint unsigned NOT NULL DEFAULT '1' COMMENT '账户状态：(1可用|2异常|3已冻结|4已注销)',
  `user_group` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所在用户组',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上次登录时间',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机号码',
  `phone_state` smallint unsigned NOT NULL DEFAULT '0' COMMENT '手机认证：(0未认证|1审核中|2已认证)',
  `user_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nick_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '邮箱',
  `email_state` smallint unsigned NOT NULL DEFAULT '0' COMMENT '邮箱认证：(0未认证|1审核中|2已认证)',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像地址',
  `open_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '针对获取用户信息字段',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户账户';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `user_name`, `nick_name`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (1, 1, '管理员', '2026-04-23 11:23:36', NULL, 0, 'admin', 'admin', 'asd123', '', 0, '/api/upload/admin_avatar.jpg', NULL, '2025-04-30 17:35:13');
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `user_name`, `nick_name`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (2, 1, '采购员', '2026-04-29 18:48:43', NULL, 0, 'youhu2', '小红', 'asd123', '', 0, '/api/upload/default_avatar.jpg', NULL, '2026-04-23 11:23:36');
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `user_name`, `nick_name`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (3, 1, '注册用户', '2026-04-23 11:23:36', NULL, 0, 'yonghu2', 'yonghu2', 'asd123', '', 0, '/api/upload/default_avatar.jpg', NULL, '2026-04-23 11:23:36');
COMMIT;

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `group_id` mediumint unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组ID',
  `display` smallint unsigned NOT NULL DEFAULT '100' COMMENT '显示顺序',
  `name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  `register` smallint unsigned DEFAULT '0' COMMENT '注册位置',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户组';

-- ----------------------------
-- Records of user_group
-- ----------------------------
BEGIN;
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (1, 100, '管理员', NULL, '', '', 0, 0, '2025-05-18 11:51:28', '2025-05-18 11:51:28');
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (2, 100, '游客', NULL, '', '', 0, 0, '2025-05-18 11:51:28', '2025-05-18 11:51:28');
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (3, 100, '注册用户', NULL, 'registered_user', 'registered_user_id', 0, 3, '2025-05-18 11:51:28', '2025-05-18 11:51:28');
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (4, 100, '采购员', '', NULL, NULL, 0, 0, '2026-04-29 17:37:17', '2026-04-29 17:37:17');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
