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

 Date: 04/05/2026 19:47:26
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
  `views` int unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='文章';

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` (`article_id`, `title`, `type`, `views`, `praise_len`, `create_time`, `update_time`, `source`, `url`, `tag`, `content`, `img`, `description`) VALUES (8, '🐾 2026年宠物行业最新资讯与养护指南', '宠物', 3, 1, '2026-05-03 16:26:22', '2026-05-03 16:37:51', '', '', '📊 2026宠物市场新趋势', '<h3>养宠群体年轻化</h3><p>90后宠主占比42.7%，成为消费主力</p><p>猫狗仍是绝对主流，犬、猫饲养家庭占比均超50%</p><p><br></p>', '/api/upload/1777796551.png', '2026年中国宠物行业市场规模已迈过3100亿大关，预计增速达到15%\n养宠家庭比例攀升至十年峰值56.1%，全国犬猫数量突破1.26亿，远超同年新生儿数量\n');
INSERT INTO `article` (`article_id`, `title`, `type`, `views`, `praise_len`, `create_time`, `update_time`, `source`, `url`, `tag`, `content`, `img`, `description`) VALUES (9, '📰【新品速递】「星跃X1」智能生态手表：健康监测与无缝互联的完美融合', '商品', 0, 0, '2026-05-04 15:32:26', '2026-05-04 15:32:26', '', '', '智能生态手表', '<p>随着可穿戴设备算法与低功耗芯片的持续突破，今日正式亮相的**「星跃X1」智能生态手表**重新定义了日常健康管理与全场景智能生活的边界。新品以“精准、持久、无感互联”为核心设计理念，面向都市运动人群与高效办公族打造全天候数字健康管家。</p><h4>核心亮点</h4><p>✅ 医疗级精准监测：搭载新一代多通道生物传感器，支持24小时心率、血氧饱和度、睡眠分期与压力指数追踪，异常数据实时提醒。</p><p>✅ 7天超长续航：内置低功耗双核架构，典型使用场景下续航达7天；支持10分钟快充，满足3天日常使用。</p><p>✅ 全生态无缝互联：深度适配iOS/Android/鸿蒙系统，来电、日程、导航、智能家居控制一表触达；eSIM版支持独立通话与在线音乐。</p><p>✅ 轻奢耐用设计：航空级钛合金中框+蓝宝石微晶玻璃镜面，5ATM防水等级，适配运动、通勤、差旅全场景。</p>', '/api/upload/1777879821.png', '');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
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
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`type_id`, `display`, `name`, `father_id`, `description`, `icon`, `url`, `create_time`, `update_time`) VALUES (2, 100, '宠物', 0, '', '', '', '2026-05-03 16:21:26', '2026-05-03 16:21:26');
INSERT INTO `category` (`type_id`, `display`, `name`, `father_id`, `description`, `icon`, `url`, `create_time`, `update_time`) VALUES (3, 100, '商品', 0, '', '', '', '2026-05-04 15:31:07', '2026-05-04 15:31:07');
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
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='定制授权';

-- ----------------------------
-- Records of auth
-- ----------------------------
BEGIN;
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (1, '管理员', '注册用户管理', 'registered_user', '注册用户', '/registered_user/table', NULL, 'list', 1, 1, 1, 1, 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:18');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (2, '管理员', '注册用户管理', 'registered_user', '注册用户', '/registered_user/view', NULL, 'view', 1, 1, 1, 1, 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', 'registered_user_id, user_name, user_gender, examine_state, user_id, create_time, update_time', '', 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:31');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (3, '管理员', '商品信息', 'commodity_information', '商品信息', '/commodity_information/table', NULL, 'list', 1, 1, 1, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-04 16:56:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (4, '管理员', '商品信息', 'commodity_information', '商品信息', '/commodity_information/view', NULL, 'view', 1, 1, 1, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'sales_information,purchasing_information,inventory_information,purchasing_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-04 16:56:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (5, '管理员', '供应信息', 'supply_information', '供应信息', '/supply_information/table', NULL, 'list', 1, 1, 1, 1, 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:38');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (6, '管理员', '供应信息', 'supply_information', '供应信息', '/supply_information/view', NULL, 'view', 1, 1, 1, 1, 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', 'supply_information_id, supplier_name, suppliers_phone_number, commodity_category, comprehensive_evaluation, supply_frequency, supply_products, product_quality, cooperation_situation, create_time, update_time', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:41');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (7, '管理员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/table', NULL, 'list', 1, 1, 1, 1, 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:48');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (8, '管理员', '采购信息', 'purchasing_information', '采购信息', '/purchasing_information/view', NULL, 'view', 1, 1, 1, 1, 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', 'purchasing_information_id, product_code, product_name, product_category, product_brand, commodity_specifications, commodity_price, purchase_order_number, supplier_name, purchase_date, purchase_quantity, purchase_unit_price, total_purchase_price, procurement_status, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:50');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (9, '管理员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/table', NULL, 'list', 1, 1, 1, 1, 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:53');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (10, '管理员', '库存信息', 'inventory_information', '库存信息', '/inventory_information/view', NULL, 'view', 1, 1, 1, 1, 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', 'inventory_information_id, product_code, product_name, product_category, product_brand, product_inventory, check_date, check_quantity, inventory, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (11, '管理员', '销售信息', 'sales_information', '销售信息', '/sales_information/table', NULL, 'list', 1, 1, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:08:58');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (12, '管理员', '销售信息', 'sales_information', '销售信息', '/sales_information/view', NULL, 'view', 1, 1, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:00');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (13, '管理员', '资源', 'article', '文章资讯', '/article/table', NULL, 'list', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:49:51');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (14, '管理员', '资源', 'article', '文章资讯', '/article/view', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:49:53');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (15, '管理员', '资讯分类', 'category', '资讯分类', '/category/table', NULL, 'list', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:07');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (16, '管理员', '资讯分类', 'category', '资讯分类', '/category/view', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:10');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (17, '管理员', '评论', 'comment', '评论列表', '/comment/table', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:40:23');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (18, '管理员', '评论', 'comment', '评论详情', '/comment/view', NULL, 'view', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:40:24');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (19, '管理员', '系统公告', 'announcement', '公告列表', '/announcement/table', NULL, 'list', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:18');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (20, '管理员', '系统公告', 'announcement', '公告详情', '/announcement/view', NULL, 'view', 1, 1, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 15:09:20');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (21, '注册用户', '行业资讯', 'article', '资讯详情', '/article/details', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:06:06', '2026-05-03 15:09:22');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (22, '注册用户', '行业资讯', 'article', '资讯详情', '/article/list', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, descriptionarticle_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:22:30', '2026-05-03 15:09:24');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (23, '注册用户', '商品信息', 'commodity_information', '商品信息', '/commodity_information/list', 'top', 'list', 0, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', '', 0, NULL, 0, NULL, '2026-04-27 17:26:56', '2026-05-04 16:56:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (24, '注册用户', '商品信息', 'commodity_information', '商品详情', '/commodity_information/details', NULL, 'view', 1, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', '', 0, NULL, 0, '', '2026-04-27 17:26:56', '2026-05-04 16:56:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (25, '注册用户', '商品信息', 'commodity_information', '商品列表', '/commodity_information/table', NULL, 'list', 0, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'sales_information,purchasing_information,inventory_information,purchasing_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-04 16:56:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (26, '注册用户', '商品信息', 'commodity_information', '商品信息', '/commodity_information/view', NULL, 'view', 0, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'sales_information,purchasing_information,inventory_information,purchasing_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-04 16:56:56');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (27, '注册用户', '销售信息', 'sales_information', '销售信息', '/sales_information/table', NULL, 'list', 1, 0, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, '{\"pay\": true}\n', '2026-04-27 15:28:13', '2026-05-03 15:48:43');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (28, '注册用户', '销售信息', 'sales_information', '销售信息', '/sales_information/view', NULL, 'view', 1, 0, 1, 1, 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', 'sales_information_id, product_code, product_name, product_category, product_brand, commodity_price, sales_order_number, registered_user, user_name, order_quantity, total_order_price, note_information, pay_state, pay_type, create_time, update_time, source_table, source_id, source_user_id', NULL, 0, NULL, 0, '{\"pay\": true}\n', '2026-04-27 15:28:13', '2026-05-03 16:17:27');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (29, '注册用户', '评论', 'comment', '评论列表', '/comment/table', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:30:23');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (30, '注册用户', '评论', 'comment', '评论详情', '/comment/view', NULL, 'view', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:03:20');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (31, '注册用户', '评论', 'comment', '评论列表', '/comment/list', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:30:23');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (32, '管理员', '评论', 'comment', '评论列表', '/comment/list', NULL, 'list', 1, 1, 1, 1, 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'comment_id,user_id,reply_to_id,content,nickname,avatar,create_time,update_time,source_table,source_field,source_id', 'commodity_information', 1, NULL, 0, NULL, '2026-04-27 15:28:13', '2026-05-03 17:40:01');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (33, '管理员', '行业资讯', 'article', '资讯详情', '/article/details', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:06:06', '2026-05-03 17:50:58');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (34, '管理员', '行业资讯', 'article', '资讯详情', '/article/list', NULL, 'view', 1, 1, 1, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, descriptionarticle_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-04-27 17:22:30', '2026-05-03 17:51:04');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (35, '管理员', '商品信息', 'commodity_information', '商品信息', '/commodity_information/list', 'top', 'list', 0, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', '', 0, NULL, 0, NULL, '2026-04-27 17:26:56', '2026-05-04 17:13:00');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (36, '游客', '商品信息', 'commodity_information', '商品列表', '/commodity_information/list', NULL, 'list', 0, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 16:56:02', '2026-05-04 17:16:52');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (37, '游客', '商品信息', 'commodity_information', '商品详情', '/commodity_information/details', NULL, 'view', 0, 0, 0, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 16:56:17', '2026-05-04 17:16:55');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (38, '游客', '行业资讯', 'article', '资讯列表', '/article/list', NULL, 'list', 0, 0, 0, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-05-04 16:58:42', '2026-05-04 17:16:57');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (39, '游客', '行业资讯', 'article', '资讯详情', '/article/details', NULL, 'view', 0, 0, 0, 1, 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', 'article_id, title, type, views, praise_len, create_time, update_time, source, url, tag, content, img, description', NULL, 0, NULL, 0, NULL, '2026-05-04 16:58:51', '2026-05-04 17:16:59');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (40, '游客', '资讯分类', 'category', '资讯分类', '/category/list', NULL, 'list', 0, 0, 0, 1, 'category_id,name,create_time,update_time', 'category_id,name,create_time,update_time', 'category_id,name,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 16:59:01', '2026-05-04 17:17:02');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (41, '游客', '公告信息', 'announcement', '公告列表', '/announcement/list', NULL, 'list', 0, 0, 0, 1, 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 16:59:11', '2026-05-04 17:17:04');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (42, '游客', '公告信息', 'announcement', '公告详情', '/announcement/details', NULL, 'view', 0, 0, 0, 1, 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 16:59:34', '2026-05-04 17:17:06');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (43, '管理员', '商品信息', 'commodity_information', '商品详情', '/commodity_information/details', NULL, 'view', 1, 1, 1, 1, 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', 'commodity_information_id,product_code,product_name,product_category,product_brand,commodity_specifications,product_inventory,product_images,commodity_price,product_introduction,product_details,views,praise_len,collect_len,comment_len,sales_information_limit_times,purchasing_information_limit_times,inventory_information_limit_times,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 17:14:12', '2026-05-04 17:17:09');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (44, '管理员', '公告信息', 'announcement', '公告详情', '/announcement/details', NULL, 'view', 1, 1, 1, 1, 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 17:14:34', '2026-05-04 17:17:11');
INSERT INTO `auth` (`auth_id`, `user_group`, `mod_name`, `table_name`, `page_title`, `path`, `position`, `mode`, `add`, `del`, `set`, `get`, `field_add`, `field_set`, `field_get`, `table_nav_name`, `table_nav`, `parent`, `parent_sort`, `option`, `create_time`, `update_time`) VALUES (45, '管理员', '公告信息', 'announcement', '公告列表', '/announcement/list', NULL, 'list', 0, 0, 0, 1, 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', 'announcement_id,title,content,create_time,update_time', NULL, 0, NULL, 0, NULL, '2026-05-04 17:14:56', '2026-05-04 17:17:13');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='收藏';

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
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
  PRIMARY KEY (`comment_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='评论';

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` (`comment_id`, `user_id`, `reply_to_id`, `content`, `nick_name`, `avatar`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (2, 1, 0, '<p>用</p>', 'admin', '/api/upload/admin_avatar.jpg', '2026-05-03 17:51:17', '2026-05-03 17:51:17', 'article', 'article_id', 7);
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
  `views` int NOT NULL DEFAULT '0' COMMENT '点击数',
  `praise_len` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `collect_len` int NOT NULL DEFAULT '0' COMMENT '收藏数',
  `comment_len` int NOT NULL DEFAULT '0' COMMENT '评论数',
  `sales_information_limit_times` int NOT NULL DEFAULT '0' COMMENT '销售限制次数',
  `purchasing_information_limit_times` int NOT NULL DEFAULT '0' COMMENT '采购限制次数',
  `inventory_information_limit_times` int NOT NULL DEFAULT '0' COMMENT '库存限制次数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
  PRIMARY KEY (`commodity_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品信息';

-- ----------------------------
-- Records of commodity_information
-- ----------------------------
BEGIN;
INSERT INTO `commodity_information` (`commodity_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_specifications`, `product_inventory`, `product_images`, `commodity_price`, `product_introduction`, `product_details`, `views`, `praise_len`, `collect_len`, `comment_len`, `sales_information_limit_times`, `purchasing_information_limit_times`, `inventory_information_limit_times`, `create_time`, `update_time`) VALUES (21, '1777695462707', 'shangpi1', '零食', 'ionf', '100ml', 0.00, '/api/upload/O1CN01EBbQPP1q2CWxm7wtb_!!4611686018427385277-0-item_pic.jpg_460x460q90.jpg_.webp', 4.00, '', '', 31, 1, 0, 0, 0, 0, 0, '2026-05-02 12:18:57', '2026-05-04 16:56:29');
INSERT INTO `commodity_information` (`commodity_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_specifications`, `product_inventory`, `product_images`, `commodity_price`, `product_introduction`, `product_details`, `views`, `praise_len`, `collect_len`, `comment_len`, `sales_information_limit_times`, `purchasing_information_limit_times`, `inventory_information_limit_times`, `create_time`, `update_time`) VALUES (23, '1777879472353', 'jfo', '日用', 'gre', '100*100', 3.00, '/api/upload/O1CN01A1wr3R26fA5Ne05Sj_!!2219275407688.png_460x460q90.jpg_.webp', 5.00, '', '', 2, 1, 0, 0, 0, 0, 0, '2026-05-04 15:25:21', '2026-05-04 16:53:22');
COMMIT;

-- ----------------------------
-- Table structure for views
-- ----------------------------
DROP TABLE IF EXISTS `views`;
CREATE TABLE `views` (
  `views_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '点赞人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  PRIMARY KEY (`views_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户点击';

-- ----------------------------
-- Records of views
-- ----------------------------
BEGIN;
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (1, 2, '2026-04-26 15:42:49', '2026-04-26 15:42:49', 'commodity_information', 'commodity_information_id', 10);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (2, 2, '2026-04-27 17:27:14', '2026-04-27 17:27:14', 'commodity_information', 'commodity_information_id', 1);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (3, 2, '2026-04-27 17:27:27', '2026-04-27 17:27:27', 'commodity_information', 'commodity_information_id', 2);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (4, 2, '2026-04-27 18:05:15', '2026-04-27 18:05:15', 'commodity_information', 'commodity_information_id', 2);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (5, 2, '2026-04-27 18:19:54', '2026-04-27 18:19:54', 'commodity_information', 'commodity_information_id', 2);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (6, 2, '2026-04-27 18:20:02', '2026-04-27 18:20:02', 'commodity_information', 'commodity_information_id', 19);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (7, 2, '2026-04-27 18:20:21', '2026-04-27 18:20:21', 'commodity_information', 'commodity_information_id', 18);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (8, 2, '2026-04-27 18:21:42', '2026-04-27 18:21:42', 'commodity_information', 'commodity_information_id', 18);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (9, 2, '2026-04-27 18:21:52', '2026-04-27 18:21:52', 'commodity_information', 'commodity_information_id', 20);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (10, 2, '2026-04-27 18:24:16', '2026-04-27 18:24:16', 'commodity_information', 'commodity_information_id', 20);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (11, 2, '2026-04-27 18:24:33', '2026-04-27 18:24:33', 'commodity_information', 'commodity_information_id', 14);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (12, 3, '2026-05-02 12:33:23', '2026-05-02 12:33:23', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (13, 3, '2026-05-03 12:55:40', '2026-05-03 12:55:40', 'commodity_information', 'commodity_information_id', 22);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (14, 3, '2026-05-03 12:58:28', '2026-05-03 12:58:28', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (15, 3, '2026-05-03 13:00:42', '2026-05-03 13:00:42', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (16, 3, '2026-05-03 13:02:17', '2026-05-03 13:02:17', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (17, 3, '2026-05-03 14:01:35', '2026-05-03 14:01:35', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (18, 3, '2026-05-03 14:14:15', '2026-05-03 14:14:15', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (19, 3, '2026-05-03 14:14:25', '2026-05-03 14:14:25', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (20, 3, '2026-05-03 14:14:31', '2026-05-03 14:14:31', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (21, 3, '2026-05-03 15:36:48', '2026-05-03 15:36:48', 'commodity_information', 'commodity_information_id', 22);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (22, 3, '2026-05-03 15:37:01', '2026-05-03 15:37:01', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (23, 2, '2026-05-03 16:38:43', '2026-05-03 16:38:43', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (24, 2, '2026-05-03 17:25:15', '2026-05-03 17:25:15', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (25, 2, '2026-05-03 17:25:51', '2026-05-03 17:25:51', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (26, 2, '2026-05-03 17:28:36', '2026-05-03 17:28:36', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (27, 2, '2026-05-03 17:30:33', '2026-05-03 17:30:33', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (28, 2, '2026-05-03 17:30:55', '2026-05-03 17:30:55', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (29, 2, '2026-05-03 17:31:24', '2026-05-03 17:31:24', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (30, 2, '2026-05-03 17:31:34', '2026-05-03 17:31:34', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (31, 2, '2026-05-03 17:32:29', '2026-05-03 17:32:29', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (32, 2, '2026-05-04 15:28:04', '2026-05-04 15:28:04', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (33, 2, '2026-05-04 15:57:32', '2026-05-04 15:57:32', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (34, 2, '2026-05-04 16:03:32', '2026-05-04 16:03:32', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (35, 2, '2026-05-04 16:04:46', '2026-05-04 16:04:46', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (36, 2, '2026-05-04 16:06:39', '2026-05-04 16:06:39', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (37, 2, '2026-05-04 16:06:46', '2026-05-04 16:06:46', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (38, 2, '2026-05-04 16:07:00', '2026-05-04 16:07:00', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (39, 2, '2026-05-04 16:08:36', '2026-05-04 16:08:36', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (40, 2, '2026-05-04 16:09:01', '2026-05-04 16:09:01', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (41, 2, '2026-05-04 16:09:09', '2026-05-04 16:09:09', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (42, 2, '2026-05-04 16:10:18', '2026-05-04 16:10:18', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (43, 2, '2026-05-04 16:16:58', '2026-05-04 16:16:58', 'commodity_information', 'commodity_information_id', 21);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (44, 2, '2026-05-04 16:27:24', '2026-05-04 16:27:24', 'commodity_information', 'commodity_information_id', 23);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (45, 2, '2026-05-04 16:29:49', '2026-05-04 16:29:49', 'commodity_information', 'commodity_information_id', 23);
INSERT INTO `views` (`views_id`, `user_id`, `create_time`, `update_time`, `source_table`, `source_field`, `source_id`) VALUES (46, 0, '2026-05-04 16:56:29', '2026-05-04 16:56:29', 'commodity_information', 'commodity_information_id', 21);
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
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
  PRIMARY KEY (`inventory_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='库存信息';

-- ----------------------------
-- Records of inventory_information
-- ----------------------------
BEGIN;
INSERT INTO `inventory_information` (`inventory_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `product_inventory`, `check_date`, `check_quantity`, `inventory`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777695462707', 'shangpi1', '零食', 'ionf', 0.00, '2026-05-03', 3.00, '', '2026-05-03 12:51:43', '2026-05-03 12:51:43', 'commodity_information', 21, 1);
COMMIT;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `announcement_id` mediumint unsigned NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(125) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '正文',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`announcement_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='公告';

-- ----------------------------
-- Records of announcement
-- ----------------------------
BEGIN;
INSERT INTO `announcement` (`announcement_id`, `title`, `content`, `create_time`, `update_time`) VALUES (5, '网站公告', '<p>✅ 平台提供以下核心服务：</p><ul><li>商品管理：类目维护、SKU管理、多仓库存同步</li><li>订单协同：订单自动分发、状态追踪、异常预警</li><li>供应链金融：账期管理、对账结算、电子发票</li><li>物流对接：主流快递/仓储系统API直连、运单智能匹配</li><li>数据分析：经营报表、库存周转、履约时效可视化</li><li>权限管理：多角色账号体系、操作日志审计</li></ul><p>❌ 以下情形不属于平台服务保障范围：</p><ul><li>用户未按操作规范导致的业务异常</li><li>第三方系统（如快递、支付、ERP）故障引发的链路中断</li><li>因用户网络环境、设备兼容性问题造成的访问异常</li><li>不可抗力（如自然灾害、政策调整、黑客攻击）导致的服务暂停</li></ul><p><br></p>', '2026-05-04 19:19:34', '2026-05-04 19:23:03');
INSERT INTO `announcement` (`announcement_id`, `title`, `content`, `create_time`, `update_time`) VALUES (6, '网站介绍', '<p><span style=\"color: rgb(140, 141, 155);\">小智电商供应链管理平台是一款专为电商企业、品牌商家及供应链服务商打造的一站式智能协同系统。</span></p><p><span style=\"color: rgb(140, 141, 155);\">通过「订单+库存+物流+财务」全链路数字化整合，帮助客户实现供应链可视、可控、可优化，降本增效，敏捷响应市场变化</span></p><h2><span class=\"ql-cursor\">﻿</span>适用客户群体</h2><p>✅ 电商品牌方：多平台开店、多仓发货，需统一管控供应链</p><p>✅ 代运营/TP服务商：为多个品牌提供供应链托管服务</p><p>✅ 批发分销商：上下游协同复杂，需高效订单流转与对账</p><p>✅ 跨境卖家：涉及海外仓、报关、多币种结算等复杂场景</p><p>✅ 制造业转型电商：从生产到零售的端到端供应链数字化</p>', '2026-05-04 19:23:58', '2026-05-04 19:24:32');
INSERT INTO `announcement` (`announcement_id`, `title`, `content`, `create_time`, `update_time`) VALUES (7, '关于我们', '<h2>公司简介</h2><p>小智电商供应链管理平台（Xiaozhi Supply Chain Platform）成立于<span style=\"background-color: rgb(239, 238, 255); color: rgb(97, 92, 237); font-size: 11.05px;\">202X年</span>，是一家专注于电商供应链数字化服务的高新技术企业。</p><p>我们立足<span style=\"background-color: rgb(239, 238, 255); color: rgb(97, 92, 237); font-size: 11.05px;\">[城市/总部所在地]</span>，服务辐射全国及东南亚、欧美等跨境市场，致力于为电商品牌、零售企业、供应链服务商提供端到端的智能协同解决方案。</p><ul><li><br></li></ul><p><br></p>', '2026-05-04 19:26:00', '2026-05-04 19:26:00');
INSERT INTO `announcement` (`announcement_id`, `title`, `content`, `create_time`, `update_time`) VALUES (8, '联系方式', '<p> 系统使用/技术故障</p><p>客服热线 / 工单系统</p><p>400-xxx-xxxx</p><p> 按2转技术支持</p><p>工作日 9:00-18:00</p>', '2026-05-04 19:28:40', '2026-05-04 19:28:40');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='点赞';

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
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
  PRIMARY KEY (`purchasing_information_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='采购信息';

-- ----------------------------
-- Records of purchasing_information
-- ----------------------------
BEGIN;
INSERT INTO `purchasing_information` (`purchasing_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_specifications`, `commodity_price`, `purchase_order_number`, `supplier_name`, `purchase_date`, `purchase_quantity`, `purchase_unit_price`, `total_purchase_price`, `procurement_status`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (13, '1777695462707', 'shangpi1', '零食', 'ionf', '100ml', 3.00, '1777783588309', 'gw', '2026-05-03', 2.00, 4.00, 8.00, '', '2026-05-03 12:46:42', '2026-05-03 16:16:07', 'commodity_information', 21, 1);
INSERT INTO `purchasing_information` (`purchasing_information_id`, `product_code`, `product_name`, `product_category`, `product_brand`, `commodity_specifications`, `commodity_price`, `purchase_order_number`, `supplier_name`, `purchase_date`, `purchase_quantity`, `purchase_unit_price`, `total_purchase_price`, `procurement_status`, `create_time`, `update_time`, `source_table`, `source_id`, `source_user_id`) VALUES (15, '1777879472353', 'jfo', '日用', 'gre', '100*100', 5.00, '1777884772063', 'gw', '2026-05-04', 3.00, 1.00, 3.00, '', '2026-05-04 16:53:22', '2026-05-04 16:53:22', 'commodity_information', 23, 1);
COMMIT;

-- ----------------------------
-- Table structure for registered_user
-- ----------------------------
DROP TABLE IF EXISTS `registered_user`;
CREATE TABLE `registered_user` (
  `registered_user_id` int NOT NULL AUTO_INCREMENT COMMENT '注册用户ID',
  `user_name` varchar(64) DEFAULT NULL COMMENT '用户姓名',
  `user_gender` int DEFAULT NULL COMMENT '用户性别',
  `examine_state` varchar(16) NOT NULL DEFAULT '已通过' COMMENT '审核状态',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户ID',
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`registered_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='注册用户';

-- ----------------------------
-- Records of registered_user
-- ----------------------------
BEGIN;
INSERT INTO `registered_user` (`registered_user_id`, `user_name`, `user_gender`, `examine_state`, `user_id`, `create_time`, `update_time`) VALUES (4, 'admin', 0, '已通过', 5, '2026-05-04 19:31:19', '2026-05-04 19:31:19');
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
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
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
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `banner_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '内容',
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '链接',
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '轮播图',
  `views` int unsigned NOT NULL DEFAULT '0' COMMENT '点击量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`banner_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='轮播图';

-- ----------------------------
-- Records of banner
-- ----------------------------
BEGIN;
INSERT INTO `banner` (`banner_id`, `title`, `content`, `url`, `img`, `views`, `create_time`, `update_time`) VALUES (4, '鞋子', '', '/commodity_information/list', '/api/upload/O1CN01EBbQPP1q2CWxm7wtb_!!4611686018427385277-0-item_pic.jpg_460x460q90.jpg_.webp', 0, '2026-04-27 18:31:29', '2026-05-04 16:48:20');
INSERT INTO `banner` (`banner_id`, `title`, `content`, `url`, `img`, `views`, `create_time`, `update_time`) VALUES (5, '手表', '', '', '/api/upload/1777884065.png', 0, '2026-05-04 16:46:21', '2026-05-04 16:46:21');
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
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
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
  `user_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nick_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '邮箱',
  `email_state` smallint unsigned NOT NULL DEFAULT '0' COMMENT '邮箱认证：(0未认证|1审核中|2已认证)',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像地址',
  `open_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '针对获取用户信息字段',
  `is_delete` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除：0未删除，1已删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户账户';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `user_name`, `nick_name`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (1, 1, '管理员', '2026-05-04 19:32:35', NULL, 0, 'admin', 'admin', 'asd123', '', 0, '/api/upload/O1CN01A1wr3R26fA5Ne05Sj_!!2219275407688.png_460x460q90.jpg_.webp', NULL, '2026-04-30 17:35:13');
INSERT INTO `user` (`user_id`, `state`, `user_group`, `login_time`, `phone`, `phone_state`, `user_name`, `nick_name`, `password`, `email`, `email_state`, `avatar`, `open_id`, `create_time`) VALUES (5, 1, '注册用户', '2026-05-04 19:31:19', NULL, 0, 'flsde', '', 'asd123', '', 0, '/api/upload/1777796551.png', NULL, '2026-05-04 19:31:19');
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
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
