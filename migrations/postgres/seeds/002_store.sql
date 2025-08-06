-- +goose Up
-- +goose StatementBegin
INSERT INTO core.store (tenant_id, id, name, status)
VALUES ('W0lFuIXW5VngqxAEXBa8H', 'P6fgunP4u9UFkvUxPEmnZ', 'unknown', 'active')
ON CONFLICT (id) DO NOTHING;
-- +goose StatementEnd
