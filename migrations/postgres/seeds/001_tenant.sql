-- +goose Up
-- +goose StatementBegin
INSERT INTO core.tenant (id, name, domain)
VALUES ('W0lFuIXW5VngqxAEXBa8H', 'tenant', 'tenant.xyz')
ON CONFLICT (id) DO NOTHING;
-- +goose StatementEnd
