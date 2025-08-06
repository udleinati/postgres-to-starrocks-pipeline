#!/bin/sh
set -e

if [ "$1"  = 'migrate' ]; then
  /root/go/bin/goose -dir /app/migrations up
  /root/go/bin/goose -dir /app/seeds -no-versioning up
  exec true
fi

exec "$@"
