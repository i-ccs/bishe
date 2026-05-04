/*
 Navicat Premium Dump SQL

 Source Server         : bao
 Source Server Type    : MySQL
 Source Server Version : 80409 (8.4.9)
 Source Host           : localhost:3306
 Source Schema         : xiaozhi

 Target Server Type    : MySQL
 Target Server Version : 80409 (8.4.9)
 File Encoding         : 65001

 Date: 04/05/2026 10:12:59
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
  `maxage` int NOT NULL DEFAULT '2' COMMENT '最大寿命：默认2小时',
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='文章';

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` (`article_id`, `title`, `type`, `hits`, `praise_len`, `create_time`, `update_time`, `source`, `url`, `tag`, `content`, `img`, `description`) VALUES (7, '咨询咨询咨询咨询咨询', '', 4, 0, '2026-05-03 12:57:02', '2026-05-03 17:51:26', '', '', '咨询咨询咨询12112312', '<p>d咨询咨询咨询咨询咨询</p>', '/api/upload/Screenshot From 2026-05-03 12-47-56.png', '咨询咨询咨询');
INSERT INTO `article` (`article_id`, `title`, `type`, `hits`, `praise_len`, `create_time`, `update_time`, `source`, `url`, `tag`, `content`, `img`, `description`) VALUES (8, '🐾 2026年宠物行业最新资讯与养护指南', '宠物', 3, 1, '2026-05-03 16:26:22', '2026-05-03 16:37:51', '', '', '📊 2026宠物市场新趋势', '<h3>养宠群体年轻化</h3><p>90后宠主占比42.7%，成为消费主力</p><p>猫狗仍是绝对主流，犬、猫饲养家庭占比均超50%</p><p><br></p>', '/api/upload/1777796551.png', '2026年中国宠物行业市场规模已迈过3100亿大关，预计增速达到15%\n养宠家庭比例攀升至十年峰值56.1%，全国犬猫数量突破1.26亿，远超同年新生儿数量\n');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='文章分类';

-- ----------------------------
-- Records of article_type
-- ----------------------------
BEGIN;
INSERT INTO `article_type` (`type_id`, `display`, `name`, `father_id`, `description`, `icon`, `url`, `create_time`, `update_time`) VALUES (2, 100, '宠物', 0, '', '', '', '2026-05-03 16:21:26', '2026-05-03 16:21:26');
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
  `parent` varchar(64) DEFAULT NULL COMMENT '父级模块名',
  `parent_sort` int DEFAULT '0' COMMENT '父级排序',
  `option` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '配置',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='定制授权';

-- ----------------------------
-- Records of auth
-- ----------------------------
BEGIN;
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (1, '管理员', '注册用户管理', 'registered_user', '注册用户', '/registered_user/table', NULL, 'list', 1, 1, 1, 1, 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:18');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (2, '管理员', '注册用户管理', 'registered_user', '注册用户', '/registered_user/view', NULL, 'view', 1, 1, 1, 1, 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', '', 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:31');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (3, '管理员', '商品信息', 'commodity_information', '商品信息', '/commodity_information/table', NULL, 'list', 1, 1, 1, 1, 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:34');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (4, '管理员', '商品信息', 'commodity_information', '商品信息', '/commodity_information/view', NULL, 'view', 1, 1, 1, 1, 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'sales_information,purchasing_information,inventory_information,purchasing_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:36');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (5, '管理员', '供应信息', 'supply_information', '供应信息', '/supply_information/table', NULL, 'list', 1, 1, 1, 1, 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:38');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (6, '管理员', '供应信息', 'supply_information', '供应信息', '/supply_information/view', NULL, 'view', 1, 1, 1, 1, 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:41');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (7, '管理员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/table', NULL, 'list', 1, 1, 1, 1, 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:48');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (8, '管理员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/view', NULL, 'view', 1, 1, 1, 1, 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:50');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (9, '管理员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/table', NULL, 'list', 1, 1, 1, 1, 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:53');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (10, '管理员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/view', NULL, 'view', 1, 1, 1, 1, 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (11, '管理员', '销售信息', 'sales_information', '销售信息', '/sales_information/table', NULL, 'list', 1, 1, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:58');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (12, '管理员', '销售信息', 'sales_information', '销售信息', '/sales_information/view', NULL, 'view', 1, 1, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:00');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (13, '管理员', '资源', 'article', '文章资讯', '/article/table', NULL, 'list', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:49:51');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (14, '管理员', '资源', 'article', '文章资讯', '/article/view', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:49:53');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (15, '管理员', '资讯分类', 'article_type', '资讯分类', '/article_type/table', NULL, 'list', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:07');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (16, '管理员', '资讯分类', 'article_type', '资讯分类', '/article_type/view', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:10');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (17, '管理员', '评论', 'comment', '评论列表', '/comment/table', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:40:23');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (18, '管理员', '评论', 'comment', '评论详情', '/comment/view', NULL, 'view', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:40:24');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (19, '管理员', '系统公告', 'notice', '公告列表', '/notice/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:18');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (20, '管理员', '系统公告', 'notice', '公告详情', '/notice/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:20');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (21, '注册用户', '行业资讯', 'article', '资讯详情', '/article/details', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:06:06', '2026-05-03 15:09:22');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (22, '注册用户', '行业资讯', 'article', '资讯详情', '/article/list', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, descriptionarticle_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:22:30', '2026-05-03 15:09:24');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (23, '注册用户', '商品信息', 'commodity_information', '商品信息', '/commodity_information/list', 'top', 'list', 0, 0, 0, 1, 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', '', 0, NULL, 0, NULL, '2026-04-27 17:26:56', '2026-05-03 15:09:27');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (24, '注册用户', '商品信息', 'commodity_information', '商品详情', '/commodity_information/details', NULL, 'view', 1, 0, 0, 1, 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', '', 0, NULL, 0, '', '2026-04-27 17:26:56', '2026-05-03 17:23:21');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (25, '注册用户', '商品信息', 'commodity_information', '商品列表', '/commodity_information/table', NULL, 'list', 0, 0, 0, 1, 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'sales_information,purchasing_information,inventory_information,purchasing_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:31');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (26, '注册用户', '商品信息', 'commodity_information', '商品信息', '/commodity_information/view', NULL, 'view', 0, 0, 0, 1, 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'ommodity_information_id,commodity_price,commodity_specifications,create_time,hits,inventory_information_limit_times,praise_len,product_brand,product_category,product_code,product_details,product_images,product_introduction,product_inventory,product_name,purchasing_information_limit_times,sales_information_limit_times,update_time,collect_len,comment_len', 'sales_information,purchasing_information,inventory_information,purchasing_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:33');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (27, '注册用户', '销售信息', 'sales_information', '销售信息', '/sales_information/table', NULL, 'list', 1, 0, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, '{\"pay\": true}\n', '2026-04-27 15:28:13', '2026-05-03 15:48:43');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (28, '注册用户', '销售信息', 'sales_information', '销售信息', '/sales_information/view', NULL, 'view', 1, 0, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, '{\"pay\": true}\n', '2026-04-27 15:28:13', '2026-05-03 16:17:27');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (29, '注册用户', '评论', 'comment', '评论列表', '/comment/table', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:30:23');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (30, '注册用户', '评论', 'comment', '评论详情', '/comment/view', NULL, 'view', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:03:20');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (31, '注册用户', '评论', 'comment', '评论列表', '/comment/list', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:30:23');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (32, '管理员', '评论', 'comment', '评论列表', '/comment/list', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:40:01');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (33, '管理员', '行业资讯', 'article', '资讯详情', '/article/details', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:06:06', '2026-05-03 17:50:58');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (34, '管理员', '行业资讯', 'article', '资讯详情', '/article/list', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, descriptionarticle_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, hits, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:22:30', '2026-05-03 17:51:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='收藏';

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
INSERT INTO `collect` (`collect_id`, `user_id`, `source_table`, `source_field`, `source_id`, `title`, `img`, `create_time`, `update_time`) VALUES (2, 3, 'commodity_information', 'commodity_information_id', 21, 'shangpi1', '/api/upload/O1CN01EBbQPP1q2CWxm7wtb_!!4611686018427385277-0-item_pic.jpg_460x460q90.jpg_.webp', '2026-05-03 14:14:33', '2026-05-03 14:14:33');
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
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  PRIMARY KEY (`comment_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='评论';

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` (`comment_id`, `user_id`, `reply_to_id`, `content`, `nickname`, `avatar`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (1, 2, 0, '<p>好</p>', 'yonghu1', '/api/upload/default_avatar.jpg', '2026-05-03 17:26:01', '2026-05-03 17:26:01', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `comment` (`comment_id`, `user_id`, `reply_to_id`, `content`, `nickname`, `avatar`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (2, 1, 0, '<p>用</p>', 'admin', '/api/upload/admin_avatar.jpg', '2026-05-03 17:51:17', '2026-05-03 17:51:17', 'article', 'article_id', 7);
COMMIT;

-- ----------------------------
-- Table structure for commodity_information
-- ----------------------------
DROP TABLE IF EXISTS `commodity_information`;
CREATE TABLE `commodity_information` (
  `commodity_information_id` int NOT NULL AUTO_INCREMENT COMMENT '商品信息ID',
  `product_code` varchar(64) DEFAULT NULL COMMENT '商品编码',
  `product_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `product_category` varchar(64) DEFAULT NULL COMMENT '商品类别',
  `product_brand` varchar(64) DEFAULT NULL COMMENT '商品品牌',
  `commodity_specifications` varchar(64) DEFAULT NULL COMMENT '商品规格',
  `product_inventory` double(8,2) DEFAULT '0.00' COMMENT '商品库存',
  `product_images` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `commodity_price` double(8,2) DEFAULT '0.00' COMMENT '商品价格',
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
  PRIMARY KEY (`commodity_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品信息';

-- ----------------------------
-- Records of commodity_information
-- ----------------------------
BEGIN;
INSERT INTO `commodity_information` (`commodity_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_specifications`, `product_inventory`, `product_images`, `commodity_price`, `product_introduction`, `product_details`, `hits`, `praise_len`, `collect_len`, `comment_len`, `sales_information_limit_times`, `purchasing_information_limit_times`, `inventory_information_limit_times`, `create_time`, `update_time`) VALUES (21, '1777695462707', 'shangpi1', '零食', 'ionf', '100ml', 0.00, '/api/upload/O1CN01EBbQPP1q2CWxm7wtb_!!4611686018427385277-0-item_pic.jpg_460x460q90.jpg_.webp', 4.00, '', '', 18, 1, 0, 0, 0, 0, 0, '2026-05-02 12:18:57', '2026-05-03 17:32:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户点击';

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
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (12, 3, '2026-05-02 12:33:23', '2026-05-02 12:33:23', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (13, 3, '2026-05-03 12:55:40', '2026-05-03 12:55:40', 'commodity_information', 'commodity_information_id', 22);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (14, 3, '2026-05-03 12:58:28', '2026-05-03 12:58:28', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (15, 3, '2026-05-03 13:00:42', '2026-05-03 13:00:42', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (16, 3, '2026-05-03 13:02:17', '2026-05-03 13:02:17', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (17, 3, '2026-05-03 14:01:35', '2026-05-03 14:01:35', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (18, 3, '2026-05-03 14:14:15', '2026-05-03 14:14:15', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (19, 3, '2026-05-03 14:14:25', '2026-05-03 14:14:25', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (20, 3, '2026-05-03 14:14:31', '2026-05-03 14:14:31', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (21, 3, '2026-05-03 15:36:48', '2026-05-03 15:36:48', 'commodity_information', 'commodity_information_id', 22);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (22, 3, '2026-05-03 15:37:01', '2026-05-03 15:37:01', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (23, 2, '2026-05-03 16:38:43', '2026-05-03 16:38:43', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (24, 2, '2026-05-03 17:25:15', '2026-05-03 17:25:15', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (25, 2, '2026-05-03 17:25:51', '2026-05-03 17:25:51', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (26, 2, '2026-05-03 17:28:36', '2026-05-03 17:28:36', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (27, 2, '2026-05-03 17:30:33', '2026-05-03 17:30:33', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (28, 2, '2026-05-03 17:30:55', '2026-05-03 17:30:55', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (29, 2, '2026-05-03 17:31:24', '2026-05-03 17:31:24', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (30, 2, '2026-05-03 17:31:34', '2026-05-03 17:31:34', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `hits` (`hits_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (31, 2, '2026-05-03 17:32:29', '2026-05-03 17:32:29', 'commodity_information', 'commodity_information_id', 21);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='库存信息';

-- ----------------------------
-- Records of inventory_information
-- ----------------------------
BEGIN;
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777695462707', 'shangpi1', '零食', 'ionf', 0.00, '2026-05-03', 3.00, '', '2026-05-03 12:51:43', '2026-05-03 12:51:43', 'commodity_information', 21, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='点赞';

-- ----------------------------
-- Records of praise
-- ----------------------------
BEGIN;
INSERT INTO `praise` (`praise_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`, `status`) VALUES (2, 3, '2026-05-03 14:14:32', '2026-05-03 14:14:32', 'commodity_information', 'commodity_information_id', 21, 1);
INSERT INTO `praise` (`praise_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`, `status`) VALUES (3, 2, '2026-05-03 16:26:47', '2026-05-03 16:26:47', 'article', 'article_id', 8, 1);
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
  `commodity_specifications` varchar(64) DEFAULT NULL COMMENT '商品规格',
  `commodity_price` double(8,2) DEFAULT '0.00' COMMENT '商品价格',
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
INSERT INTO `purchasing_information` (`purchasing_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_specifications`, `commodity_price`, `purchase_order_number`, `supplier_name`, `purchase_date`, `purchase_quantity`, `purchase_unit_price`, `total_purchase_price`, `procurement_status`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777695462707', 'shangpi1', '零食', 'ionf', '100ml', 3.00, '1777783588309', 'gw', '2026-05-03', 2.00, 4.00, 8.00, '', '2026-05-03 12:46:42', '2026-05-03 16:16:07', 'commodity_information', 21, 1);
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
INSERT INTO `registered_user` (`registered_user_id`, `user_name`, `user_gender`, `examine_state`, `user_id`, `create_time`, `update_time`) VALUES (1, '用户姓名1', '男', '已通过', 2, '2025-05-18 11:51:27', '2026-04-27 14:15:30');
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
  `commodity_price` double(8,2) DEFAULT '0.00' COMMENT '商品价格',
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='销售信息';

-- ----------------------------
-- Records of sales_information
-- ----------------------------
BEGIN;
INSERT INTO `sales_information` (`sales_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_price`, `sales_order_number`, `registered_user`, `user_name`, `order_quantity`, `total_order_price`, `note_information`, `pay_state`, `pay_type`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777778101568', '名称', '商品类别', '商品品牌', 9.90, '1777781893946', 1, '', 0.00, 0.00, '', '未支付', '', '2026-05-03 12:18:51', '2026-05-03 12:18:51', 'commodity_information', 22, 1);
INSERT INTO `sales_information` (`sales_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_price`, `sales_order_number`, `registered_user`, `user_name`, `order_quantity`, `total_order_price`, `note_information`, `pay_state`, `pay_type`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (14, '1777778101568', '名称', '商品类别', '商品品牌', 9.90, '1777781953713', 3, '用户姓名2', 4.00, 39.60, '', '未支付', '', '2026-05-03 12:19:15', '2026-05-03 15:33:43', 'commodity_information', 22, 1);
INSERT INTO `sales_information` (`sales_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_price`, `sales_order_number`, `registered_user`, `user_name`, `order_quantity`, `total_order_price`, `note_information`, `pay_state`, `pay_type`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (15, '1777778101568', '名称', '商品类别', '商品品牌', 9.90, '1777795526318', 2, '用户姓名1', 3.00, 29.70, '', '已支付', '微信', '2026-05-03 16:05:30', '2026-05-03 16:13:59', 'commodity_information', 22, 2);
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
INSERT INTO `slides` (`slides_id`, `title`, `content`, `url`, `img`, `hits`, `create_time`, `update_time`) VALUES (4, '鞋子', '', '/article/details?article=1', '/api/upload/O1CN01EBbQPP1q2CWxm7wtb_!!4611686018427385277-0-item_pic.jpg_460x460q90.jpg_.webp', 0, '2026-04-27 18:31:29', '2026-05-02 12:17:07');
COMMIT;

-- ----------------------------
-- Table structure for supply_information
-- ----------------------------
DROP TABLE IF EXISTS `supply_information`;
CREATE TABLE `supply_information` (
  `supply_information_id` int NOT NULL AUTO_INCREMENT COMMENT '供应信息ID',
  `supplier_name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `suppliers_phone_number` varchar(16) DEFAULT NULL COMMENT '供应商电话',
  `commodity_category` varchar(64) DEFAULT NULL COMMENT '商品类别',
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
INSERT INTO `supply_information` (`supply_information_id`, `supplier_name`, `suppliers_phone_number`, `commodity_category`, `comprehensive_evaluation`, `supply_frequency`, `supply_products`, `product_quality`, `cooperation_situation`, `create_time`, `update_time`) VALUES (15, 'gw', '13658528542', '零食', '', '一 天一次', '', '', '', '2026-05-02 12:20:06', '2026-05-02 12:20:06');
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
  `username` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '昵称',
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
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `username`, `nickname`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (1, 1, '管理员', '2026-04-23 11:23:36', NULL, 0, 'admin', 'admin', 'asd123', '', 0, '/api/upload/admin_avatar.jpg', NULL, '2025-04-30 17:35:13');
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `username`, `nickname`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (2, 1, '注册用户', '2026-04-27 15:20:01', NULL, 0, 'yonghu1', 'yonghu1', 'asd123', '', 0, '/api/upload/default_avatar.jpg', NULL, '2026-04-23 11:23:36');
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `username`, `nickname`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (3, 1, '注册用户', '2026-04-23 11:23:36', NULL, 0, 'yonghu2', 'yonghu2', 'asd123', '', 0, '/api/upload/default_avatar.jpg', NULL, '2026-04-23 11:23:36');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户组';

-- ----------------------------
-- Records of user_group
-- ----------------------------
BEGIN;
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (1, 100, '管理员', NULL, '', '', 0, 0, '2025-05-18 11:51:28', '2025-05-18 11:51:28');
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (2, 100, '游客', NULL, '', '', 0, 0, '2025-05-18 11:51:28', '2025-05-18 11:51:28');
INSERT INTO `user_group` (`group_id`, `display`, `name`, `description`, `source_table`, `source_field`, `source_id`, `register`, `create_time`, `update_time`) VALUES (3, 100, '注册用户', NULL, 'registered_user', 'registered_user_id', 0, 3, '2025-05-18 11:51:28', '2025-05-18 11:51:28');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
