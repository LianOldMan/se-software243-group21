-- 软件243 第21组｜实验二数据库设计 SQL 参考草案 v0.1
-- 需求基线：实验一 requirements.md v0.5.6
-- 技术假设：MySQL 8.0.16+ / InnoDB / utf8mb4。
-- 注意：SQL 是老师规定的选做项目；本文件尚未连接 MySQL 执行，也未通过数据库实际测试。
-- 限定：本脚本建立三张核心表；不增加注册、支付、物流、评价等功能。

CREATE DATABASE IF NOT EXISTS campus_secondhand_books
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE campus_secondhand_books;

-- 一、预置账号：同一用户既可卖书，也可买其他人发布的书。
CREATE TABLE user_account (
    user_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    account_code VARCHAR(64) NOT NULL,
    CONSTRAINT pk_user_account PRIMARY KEY (user_id),
    CONSTRAINT uq_user_account_code UNIQUE (account_code),
    CONSTRAINT chk_user_account_code_nonempty CHECK (CHAR_LENGTH(TRIM(account_code)) > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户预置账号';

-- 二、书籍发布记录：系统自动写入发布时间。
CREATE TABLE book_listing (
    listing_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    seller_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(120) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    condition_grade VARCHAR(16) NOT NULL,
    description VARCHAR(500) NULL,
    availability_status VARCHAR(12) NOT NULL DEFAULT '可售',
    published_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT pk_book_listing PRIMARY KEY (listing_id),
    CONSTRAINT fk_book_listing_seller FOREIGN KEY (seller_id)
        REFERENCES user_account (user_id)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT chk_book_title_nonempty CHECK (CHAR_LENGTH(TRIM(title)) > 0),
    CONSTRAINT chk_book_author_nonempty CHECK (CHAR_LENGTH(TRIM(author)) > 0),
    CONSTRAINT chk_book_price_positive CHECK (price > 0),
    CONSTRAINT chk_book_condition_grade CHECK (
        condition_grade IN ('近全新', '轻微使用痕迹', '明显使用痕迹')),
    CONSTRAINT chk_book_availability_status CHECK (
        availability_status IN ('可售', '已预留')),
    KEY idx_listing_published (published_at DESC, listing_id DESC),
    KEY idx_listing_status_published (availability_status, published_at DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='书籍发布记录';

-- 三、预留订单：一书允许多条取消历史，但任何时刻至多一条有效订单。
-- MySQL UNIQUE 允许多条 NULL：
-- 有效订单 active_listing_id=listing_id；已取消订单 active_listing_id=NULL。
-- 因此 uq_order_active_listing 不阻止多条已取消的历史订单。
CREATE TABLE reservation_order (
    order_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    listing_id BIGINT UNSIGNED NOT NULL,
    buyer_id BIGINT UNSIGNED NOT NULL,
    order_status VARCHAR(12) NOT NULL DEFAULT '有效',
    placed_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    cancelled_at DATETIME(6) NULL DEFAULT NULL,
    request_token CHAR(36) NOT NULL,
    active_listing_id BIGINT UNSIGNED
        GENERATED ALWAYS AS (
            CASE WHEN order_status = '有效' THEN listing_id ELSE NULL END
        ) STORED,
    CONSTRAINT pk_reservation_order PRIMARY KEY (order_id),
    CONSTRAINT fk_order_listing FOREIGN KEY (listing_id)
        REFERENCES book_listing (listing_id)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT fk_order_buyer FOREIGN KEY (buyer_id)
        REFERENCES user_account (user_id)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT chk_order_status CHECK (
        order_status IN ('有效', '已取消')),
    CONSTRAINT chk_order_cancelled_at CHECK (
        (order_status = '有效' AND cancelled_at IS NULL)
        OR (order_status = '已取消' AND cancelled_at IS NOT NULL)
    ),
    CONSTRAINT chk_order_request_token_nonempty CHECK (
        CHAR_LENGTH(TRIM(request_token)) > 0),
    CONSTRAINT uq_order_active_listing UNIQUE (active_listing_id),
    CONSTRAINT uq_order_buyer_request UNIQUE (buyer_id, request_token),
    KEY idx_order_listing_status (listing_id, order_status),
    KEY idx_order_buyer_status (buyer_id, order_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='预留订单及取消历史';

-- 数据字典与约束设计说明见 03_逻辑表设计与数据字典_v0.1.md。
-- 重要：以下校验仍不能只靠本脚本：
-- 1. 非卖家本人下单（buyer_id != book_listing.seller_id）须由事务中的跨表查询验证。
-- 2. 两张表中“有效订单”与书籍“已预留”必须在同一事务更新并处理并发。
-- 3. 重复下单 request_token 的重试须返回原结果；不同逻辑动作不可复用 token。
-- 4. DECIMAL(10,2) 不能替代应用拒绝输入 12.345（不能偷偷自动舍入）。
-- 5. 书籍 published_at 不可开放给卖家自填/修改。
-- 6. B-Q-11 数据不一致自动修复策略未确认；不要静默自愈。
-- 7. MySQL 普通索引不保证 LIKE '%关键词%' 的包含检索达到 NFR-01 时延要求。
-- 实验指导书的实际 SQL 验证为选做；未执行时，不得写作“运行成功”或“通过测试”。
