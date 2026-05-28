-- 将商品信息表核心字段重命名为新的字段体系
START TRANSACTION;

UPDATE `commodity_information`
SET
    `commodity_specifications` = COALESCE(`commodity_specifications`, ''),
    `product_images` = COALESCE(`product_images`, ''),
    `product_introduction` = COALESCE(`product_introduction`, '')
WHERE `commodity_specifications` IS NULL
   OR `product_images` IS NULL
   OR `product_introduction` IS NULL;

ALTER TABLE `commodity_information`
    CHANGE COLUMN `commodity_information_id` `comm_infor_id` INT NOT NULL AUTO_INCREMENT COMMENT '商品标识',
    CHANGE COLUMN `product_code` `prod_code` VARCHAR(64) NOT NULL COMMENT '商品编码',
    CHANGE COLUMN `product_name` `prod_name` VARCHAR(64) NOT NULL COMMENT '商品名称',
    CHANGE COLUMN `product_category` `prod_category` VARCHAR(64) NOT NULL COMMENT '商品类别',
    CHANGE COLUMN `product_brand` `prod_brand` VARCHAR(64) NOT NULL COMMENT '商品品牌',
    CHANGE COLUMN `commodity_specifications` `comm_spec` VARCHAR(64) NOT NULL COMMENT '商品规格',
    CHANGE COLUMN `product_inventory` `prod_inven` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品库存',
    CHANGE COLUMN `product_images` `prod_ima` VARCHAR(255) NOT NULL COMMENT '商品图片',
    CHANGE COLUMN `commodity_price` `comm_price` DOUBLE(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
    CHANGE COLUMN `product_introduction` `prod_intro` TEXT COMMENT '商品介绍';

COMMIT;