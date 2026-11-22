-- 软件243 第21组：实验二一致性断言 A-1～A-8（仅静态检查 SQL 草案 v0.1）
-- 依据：第25组 2026-11-22 实验二外评 + 05_场景走查_v0.3.md
-- MySQL 8.0.16+ / InnoDB / utf8mb4；本脚本未执行，严禁写成“全部通过”。
-- 注意：请仅在相关事务提交后且没有并发未提交中间态时解释检查结果。
-- 所有查询预期返回 0 行（存在查询结果即发现待调查的异常），不是实际测试数据。

SET NAMES utf8mb4;
USE campus_secondhand_books;

-- A-1：已预留书必须恰有一笔有效订单。预期异常：0 行。
SELECT b.listing_id, b.availability_status, COUNT(o.order_id) AS active_count
FROM book_listing AS b
LEFT JOIN reservation_order AS o
  ON o.listing_id = b.listing_id AND o.order_status = '有效'
WHERE b.availability_status = '已预留'
GROUP BY b.listing_id, b.availability_status
HAVING COUNT(o.order_id) <> 1;

-- A-2：可售书不得有有效订单。预期异常：0 行。
SELECT b.listing_id, b.availability_status, COUNT(o.order_id) AS active_count
FROM book_listing AS b
LEFT JOIN reservation_order AS o
  ON o.listing_id = b.listing_id AND o.order_status = '有效'
WHERE b.availability_status = '可售'
GROUP BY b.listing_id, b.availability_status
HAVING COUNT(o.order_id) <> 0;

-- A-3：自购应为零（R-04）。预期异常：0 行。
SELECT o.order_id, o.listing_id, o.buyer_id, b.seller_id
FROM reservation_order AS o
JOIN book_listing AS b ON b.listing_id = o.listing_id
WHERE o.buyer_id = b.seller_id;

-- A-4：有效订单的 cancelled_at 必须为 NULL。预期异常：0 行。
SELECT order_id, listing_id, placed_at, cancelled_at
FROM reservation_order
WHERE order_status = '有效' AND cancelled_at IS NOT NULL;

-- A-5：已取消订单必须有 cancelled_at。预期异常：0 行。
SELECT order_id, listing_id, placed_at, cancelled_at
FROM reservation_order
WHERE order_status = '已取消' AND cancelled_at IS NULL;

-- A-6：生成列 active_listing_id 的非 NULL 值不可重复。预期异常：0 行。
SELECT active_listing_id, COUNT(*) AS duplicate_count
FROM reservation_order
WHERE active_listing_id IS NOT NULL
GROUP BY active_listing_id
HAVING COUNT(*) > 1;

-- A-7：取消时间不得早于订单创建时间。预期异常：0 行。
SELECT order_id, listing_id, placed_at, cancelled_at
FROM reservation_order
WHERE cancelled_at IS NOT NULL AND cancelled_at < placed_at;

-- A-8：同一买家的同一逻辑请求 token 不得出现多行。预期异常：0 行。
SELECT buyer_id, request_token, COUNT(*) AS duplicate_count
FROM reservation_order
GROUP BY buyer_id, request_token
HAVING COUNT(*) > 1;

-- 实际运行时请记录版本 SELECT VERSION()、@@sql_mode、SHOW CREATE TABLE、执行时间、
-- SQL 结果和并发/锁隔离条件；即使这些查询返回 0 行，也不能据此独立证明
-- 所有接口权限与竞争路径已安全（例如服务必须拒绝同 token 跨 listing）。
-- B-Q-11 异常数据出现后的自动修复策略仍待小组确认，不能擅自执行修复 UPDATE。
