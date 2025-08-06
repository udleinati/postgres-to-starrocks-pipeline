-- +goose Up
-- +goose StatementBegin
USE main;

CREATE TABLE core_tenant (
  `id` String NOT NULL,
  `name` String NOT NULL,
  `domain` String NOT NULL,
  `created_by` JSON NOT NULL,
  `created_at` DATETIME,
  `updated_by` JSON,
  `updated_at` DATETIME,
  `deleted_by` JSON,
  `deleted_at` DATETIME,
  `_deleted_at` DATETIME
)
PRIMARY KEY (id)
DISTRIBUTED BY HASH(id) BUCKETS 1
PROPERTIES ("replication_num" = "1", "enable_persistent_index" = "true", "compression" = "ZSTD");

CREATE TABLE core_store (
  `id` String NOT NULL,
  `tenant_id` String NOT NULL,
  `status` String NOT NULL,
  `name` String NOT NULL,
  `meta_tag` JSON NOT NULL,
  `created_by` JSON NOT NULL,
  `created_at` DATETIME,
  `updated_by` JSON,
  `updated_at` DATETIME,
  `deleted_by` JSON,
  `deleted_at` DATETIME,
  `_deleted_at` DATETIME
)
PRIMARY KEY (id)
DISTRIBUTED BY HASH(id) BUCKETS 1
PROPERTIES ("replication_num" = "1", "enable_persistent_index" = "true", "compression" = "ZSTD");

-- +goose StatementEnd
