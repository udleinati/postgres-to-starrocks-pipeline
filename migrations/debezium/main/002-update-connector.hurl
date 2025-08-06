PUT {{url}}/connectors/main/config
{
  "database.server.name": "main",
  "database.hostname": "{{db_hostname}}",
  "database.port": "{{db_port}}",
  "database.dbname": "main",
  "database.user": "{{db_user}}",
  "database.password": "{{db_password}}",
  "topic.prefix": "{{environment}}.cdc.main",
  "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
  "slot.name": "main",
  "tasks.max": "1",
  "publication.name": "main",
  "plugin.name": "pgoutput",
  "key.converter.schemas.enable": "false",
  "decimal.handling.mode": "double",
  "heartbeat.interval.ms": "60000",
  "heartbeat.action.query": "INSERT INTO public.debezium_heartbeat (id, ts) VALUES ('main', NOW()) ON CONFLICT(id) DO UPDATE SET ts=EXCLUDED.ts;",
  "poll.interval.ms": "200",
  "value.converter.schemas.enable": "false",
  "name": "main",
  "value.converter": "org.apache.kafka.connect.json.JsonConverter",
  "table.include.list": "public.debezium_heartbeat,core.*",
  "key.converter": "org.apache.kafka.connect.json.JsonConverter",
  "transforms": "Reroute",
  "transforms.Reroute.type": "io.debezium.transforms.ByLogicalTableRouter",
    "transforms.Reroute.topic.regex": "(.*)_(hash|year)_([0-9]+)",
  "transforms.Reroute.topic.replacement": "$1",
  "snapshot.mode": "never"
}

HTTP 200
