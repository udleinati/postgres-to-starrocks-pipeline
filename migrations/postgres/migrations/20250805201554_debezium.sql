-- +goose Up
-- +goose StatementBegin
CREATE TABLE "public"."debezium_heartbeat"(
  "id" text NOT NULL,
  "ts" timestamptz,
  PRIMARY KEY ("id")
);

-- +goose StatementEnd
