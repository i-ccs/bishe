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

 Date: 29/04/2026 12:34:59
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
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='定制授权';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='评论';

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品信息';

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='库存信息';

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='采购信息';

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='销售信息';

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

SET FOREIGN_KEY_CHECKS = 1;
