-- +goose Up
-- +goose StatementBegin
USE main;

CREATE TABLE public_debezium_heartbeat (
  `id` String NOT NULL,
  `ts` DATETIME,
  `_deleted_at` DATETIME
)
PRIMARY KEY (id)
DISTRIBUTED BY HASH(id) BUCKETS 1
PROPERTIES ("replication_num" = "1", "enable_persistent_index" = "true", "compression" = "ZSTD");

-- +goose StatementEnd
