-- 备份 user.open_id 到备份表，然后删除列
START TRANSACTION;

-- 创建备份表
CREATE TABLE IF NOT EXISTS user_openid_backup (
    backup_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    open_id VARCHAR(255),
    backup_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 备份现有非空 open_id
INSERT INTO user_openid_backup(user_id, open_id)
SELECT user_id, open_id FROM `user` WHERE open_id IS NOT NULL;

-- 删除列（在确认备份无误后执行）
ALTER TABLE `user` DROP COLUMN `open_id`;

COMMIT;

-- 回滚示例（如需恢复）
-- CREATE TABLE user_openid_restore AS SELECT * FROM user_openid_backup;
-- ALTER TABLE `user` ADD COLUMN `open_id` VARCHAR(255) DEFAULT NULL;
-- UPDATE `user` u JOIN user_openid_backup b ON u.user_id = b.user_id SET u.open_id = b.open_id;
