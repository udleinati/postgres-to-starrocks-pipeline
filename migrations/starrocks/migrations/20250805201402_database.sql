-- +goose Up
-- +goose StatementBegin
DROP DATABASE IF EXISTS main;
CREATE DATABASE main;
-- +goose StatementEnd