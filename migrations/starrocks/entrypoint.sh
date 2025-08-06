#!/bin/sh
set -e

if [ "$1"  = 'migrate' ]; then
  /root/go/bin/goose -dir /app/migrations -no-versioning up
  exec true
fi

exec "$@"
