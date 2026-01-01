-- +goose Up
-- 1. 建立新的 stack_config 資料表
CREATE TABLE `stack_config` (
    `id` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `disable` TINYINT(1) NOT NULL DEFAULT '0',
    `heights` JSON NOT NULL,
    `stack_count` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 2. 在 cargo_info 增加欄位
ALTER TABLE `cargo_info`
ADD COLUMN `stack_config_id` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL;

-- 3. 為新欄位增加索引
ALTER TABLE `cargo_info`
ADD INDEX `cargo_info_stack_config_id_idx` (`stack_config_id`);

-- 4. 建立外鍵約束
ALTER TABLE `cargo_info`
ADD CONSTRAINT `cargo_info_stack_config_id_fkey` FOREIGN KEY (`stack_config_id`) REFERENCES `stack_config` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- +goose Down
-- 1. 先移除外鍵約束
ALTER TABLE `cargo_info`
DROP FOREIGN KEY `cargo_info_stack_config_id_fkey`;

-- 2. 移除索引與欄位
ALTER TABLE `cargo_info` DROP INDEX `cargo_info_stack_config_id_idx`;

ALTER TABLE `cargo_info` DROP COLUMN `stack_config_id`;

-- 3. 最後刪除 stack_config 資料表
DROP TABLE `stack_config`;