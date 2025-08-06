-- +goose Up
-- +goose StatementBegin
CREATE SCHEMA "core";

CREATE TABLE "core"."tenant"(
  "id" varchar(21) NOT NULL DEFAULT nanoid(),
  "name" text NOT NULL CHECK (length(name) <= 255),
  "domain" text NOT NULL CHECK (length(name) <= 120),
  "created_by" jsonb NOT NULL DEFAULT jsonb_build_object(),
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_by" jsonb,
  "updated_at" timestamptz,
  "deleted_by" jsonb,
  "deleted_at" timestamptz,
  PRIMARY KEY (id)
);

ALTER TABLE "core"."tenant" REPLICA IDENTITY FULL;

/* store */
CREATE TYPE "core"."store_status" AS ENUM(
  'active',
  'inactive'
);

CREATE TABLE "core"."store"(
  "tenant_id" varchar(21) NOT NULL,
  "id" varchar(21) NOT NULL DEFAULT nanoid(),
  "status" core.store_status NOT NULL,
  "name" text NOT NULL CHECK (length(name) <= 255),
  "meta_tag" jsonb NOT NULL DEFAULT jsonb_build_object() CHECK (pg_column_size(meta_tag) <= 1024),
  "created_by" jsonb NOT NULL DEFAULT jsonb_build_object(),
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_by" jsonb,
  "updated_at" timestamptz,
  "deleted_by" jsonb,
  "deleted_at" timestamptz,
  PRIMARY KEY (id),
  FOREIGN KEY (tenant_id) REFERENCES core.tenant(id)
);

ALTER TABLE "core"."store" REPLICA IDENTITY FULL;

-- +goose StatementEnd
