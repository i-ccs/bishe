-- 20260528_modify_fields_migration.sql
-- Renaming columns of commodity_information, inventory_information, purchasing_information, sales_information, and supply_information tables.

START TRANSACTION;

-- 1. commodity_information table updates
ALTER TABLE `commodity_information` 
    CHANGE COLUMN `purchasing_information_limit_times` `purchasing_informtion_limit_times` INT NOT NULL DEFAULT '0' COMMENT '采购限制次数';

-- 2. inventory_information table updates
ALTER TABLE `inventory_information` 
    CHANGE COLUMN `inventory_information_id` `invent_info_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键，库存标识',
    CHANGE COLUMN `product_code` `prod_code` VARCHAR(64) NOT NULL COMMENT '商品编码',
    CHANGE COLUMN `product_inventory` `prod_invent` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品库存',
    CHANGE COLUMN `check_quantity` `check_quant` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '核对数量',
    CHANGE COLUMN `source_table` `sou_table` VARCHAR(255) DEFAULT NULL COMMENT '来源表',
    CHANGE COLUMN `source_id` `sou_id` INT DEFAULT '0' COMMENT '来源标识',
    CHANGE COLUMN `source_user_id` `sou_user_id` INT DEFAULT '0' COMMENT '来源用户';

-- 3. purchasing_information table updates
ALTER TABLE `purchasing_information` 
    CHANGE COLUMN `purchasing_information_id` `purch_inf_id` INT NOT NULL AUTO_INCREMENT COMMENT '采购标识',
    CHANGE COLUMN `product_code` `prod_code` VARCHAR(64) NOT NULL COMMENT '商品编码',
    CHANGE COLUMN `commodity_price` `comm_price` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
    CHANGE COLUMN `purchase_order_number` `purch_order_number` VARCHAR(64) NOT NULL COMMENT '采购单号',
    CHANGE COLUMN `purchase_date` `purch_date` DATE NOT NULL COMMENT '采购日期',
    CHANGE COLUMN `purchase_quantity` `purch_quantity` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '采购数量',
    CHANGE COLUMN `purchase_unit_price` `purch_unit_price` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '采购单价',
    CHANGE COLUMN `total_purchase_price` `total_purch_price` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '采购总价',
    CHANGE COLUMN `procurement_status` `procur_status` TEXT NOT NULL COMMENT '采购情况',
    CHANGE COLUMN `source_table` `sour_table` VARCHAR(255) DEFAULT NULL COMMENT '来源表',
    CHANGE COLUMN `source_id` `sour_id` INT DEFAULT '0' COMMENT '来源标识',
    CHANGE COLUMN `source_user_id` `sour_user_id` INT DEFAULT '0' COMMENT '来源用户';

-- 4. sales_information table updates
ALTER TABLE `sales_information` 
    CHANGE COLUMN `sales_information_id` `sales_infor_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键，销售标识',
    CHANGE COLUMN `product_code` `prod_code` VARCHAR(64) NOT NULL COMMENT '商品编码',
    CHANGE COLUMN `commodity_price` `comm_price` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
    CHANGE COLUMN `user_name` `user_na` VARCHAR(64) NOT NULL COMMENT '用户姓名',
    CHANGE COLUMN `note_information` `note_infor` TEXT DEFAULT NULL COMMENT '备注信息',
    CHANGE COLUMN `source_table` `sour_table` VARCHAR(255) DEFAULT NULL COMMENT '来源表',
    CHANGE COLUMN `source_id` `sour_id` INT DEFAULT '0' COMMENT '来源标识',
    CHANGE COLUMN `source_user_id` `sour_user_id` INT DEFAULT '0' COMMENT '来源用户';

-- 5. supply_information table updates
ALTER TABLE `supply_information` 
    CHANGE COLUMN `supply_information_id` `supply_infor_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键，供应标识',
    CHANGE COLUMN `supplier_name` `supplier_na` VARCHAR(64) NOT NULL COMMENT '供应商名称',
    CHANGE COLUMN `commodity_category` `comm_category` VARCHAR(64) NOT NULL COMMENT '商品类别',
    CHANGE COLUMN `comprehensive_evaluation` `compreh_eva` VARCHAR(64) DEFAULT NULL COMMENT '综合评价',
    CHANGE COLUMN `supply_frequency` `supply_freq` VARCHAR(64) NOT NULL COMMENT '供应频率',
    CHANGE COLUMN `cooperation_situation` `cooperation_situ` TEXT DEFAULT NULL COMMENT '合作情况';

-- 6. Update auth table field permissions

-- commodity_information updates
UPDATE `auth` SET 
    field_add = REPLACE(field_add, 'purchasing_information_limit_times', 'purchasing_informtion_limit_times'),
    field_set = REPLACE(field_set, 'purchasing_information_limit_times', 'purchasing_informtion_limit_times'),
    field_get = REPLACE(field_get, 'purchasing_information_limit_times', 'purchasing_informtion_limit_times');

-- inventory_information updates
UPDATE `auth` SET 
    field_add = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_add, 
        'inventory_information_id', 'invent_info_id'), 
        'product_inventory', 'prod_invent'), 
        'check_quantity', 'check_quant'), 
        'source_table', 'sou_table'), 
        'source_user_id', 'sou_user_id'), 
        'source_id', 'sou_id'),
        'product_code', 'prod_code'),
    field_set = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_set, 
        'inventory_information_id', 'invent_info_id'), 
        'product_inventory', 'prod_invent'), 
        'check_quantity', 'check_quant'), 
        'source_table', 'sou_table'), 
        'source_user_id', 'sou_user_id'), 
        'source_id', 'sou_id'),
        'product_code', 'prod_code'),
    field_get = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_get, 
        'inventory_information_id', 'invent_info_id'), 
        'product_inventory', 'prod_invent'), 
        'check_quantity', 'check_quant'), 
        'source_table', 'sou_table'), 
        'source_user_id', 'sou_user_id'), 
        'source_id', 'sou_id'),
        'product_code', 'prod_code')
WHERE table_name = 'inventory_information';

-- purchasing_information updates
UPDATE `auth` SET 
    field_add = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_add, 
        'purchasing_information_id', 'purch_inf_id'), 
        'commodity_price', 'comm_price'), 
        'purchase_order_number', 'purch_order_number'), 
        'purchase_date', 'purch_date'), 
        'purchase_quantity', 'purch_quantity'), 
        'purchase_unit_price', 'purch_unit_price'), 
        'total_purchase_price', 'total_purch_price'), 
        'procurement_status', 'procur_status'), 
        'product_code', 'prod_code'),
        'source_', 'sour_'),
    field_set = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_set, 
        'purchasing_information_id', 'purch_inf_id'), 
        'commodity_price', 'comm_price'), 
        'purchase_order_number', 'purch_order_number'), 
        'purchase_date', 'purch_date'), 
        'purchase_quantity', 'purch_quantity'), 
        'purchase_unit_price', 'purch_unit_price'), 
        'total_purchase_price', 'total_purch_price'), 
        'procurement_status', 'procur_status'), 
        'product_code', 'prod_code'),
        'source_', 'sour_'),
    field_get = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_get, 
        'purchasing_information_id', 'purch_inf_id'), 
        'commodity_price', 'comm_price'), 
        'purchase_order_number', 'purch_order_number'), 
        'purchase_date', 'purch_date'), 
        'purchase_quantity', 'purch_quantity'), 
        'purchase_unit_price', 'purch_unit_price'), 
        'total_purchase_price', 'total_purch_price'), 
        'procurement_status', 'procur_status'), 
        'product_code', 'prod_code'),
        'source_', 'sour_')
WHERE table_name = 'purchasing_information';

-- sales_information updates
UPDATE `auth` SET 
    field_add = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_add, 
        'sales_information_id', 'sales_infor_id'), 
        'commodity_price', 'comm_price'), 
        'user_name', 'user_na'), 
        'note_information', 'note_infor'), 
        'product_code', 'prod_code'),
        'source_', 'sour_'),
    field_set = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_set, 
        'sales_information_id', 'sales_infor_id'), 
        'commodity_price', 'comm_price'), 
        'user_name', 'user_na'), 
        'note_information', 'note_infor'), 
        'product_code', 'prod_code'),
        'source_', 'sour_'),
    field_get = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_get, 
        'sales_information_id', 'sales_infor_id'), 
        'commodity_price', 'comm_price'), 
        'user_name', 'user_na'), 
        'note_information', 'note_infor'), 
        'product_code', 'prod_code'),
        'source_', 'sour_')
WHERE table_name = 'sales_information';

-- supply_information updates
UPDATE `auth` SET 
    field_add = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_add, 
        'supply_information_id', 'supply_infor_id'), 
        'supplier_name', 'supplier_na'), 
        'commodity_category', 'comm_category'), 
        'comprehensive_evaluation', 'compreh_eva'), 
        'supply_frequency', 'supply_freq'), 
        'cooperation_situation', 'cooperation_situ'),
    field_set = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_set, 
        'supply_information_id', 'supply_infor_id'), 
        'supplier_name', 'supplier_na'), 
        'commodity_category', 'comm_category'), 
        'comprehensive_evaluation', 'compreh_eva'), 
        'supply_frequency', 'supply_freq'), 
        'cooperation_situation', 'cooperation_situ'),
    field_get = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(field_get, 
        'supply_information_id', 'supply_infor_id'), 
        'supplier_name', 'supplier_na'), 
        'commodity_category', 'comm_category'), 
        'comprehensive_evaluation', 'compreh_eva'), 
        'supply_frequency', 'supply_freq'), 
        'cooperation_situation', 'cooperation_situ')
WHERE table_name = 'supply_information';

-- 7. Update old comment table reference to commodity_information_id
UPDATE `comment` SET `source_field` = 'comm_infor_id' WHERE `source_table` = 'commodity_information' AND `source_field` = 'commodity_information_id';

COMMIT;
