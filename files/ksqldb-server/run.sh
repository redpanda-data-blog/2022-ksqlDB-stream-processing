#! /bin/bash

COMPONENT_DIR="/home/appuser"
CONNECT_PROPS="/etc/ksqldb-server/connect.properties"
CONFLUENT_HUB="/home/appuser/bin/confluent-hub"

# install the mysql connector
$CONFLUENT_HUB install debezium/debezium-connector-mysql:1.1.0 \
  --component-dir $COMPONENT_DIR \
  --worker-configs $CONNECT_PROPS \
  --no-prompt

# start the ksqldb server
ksql-server-start /etc/ksqldb-server/ksql-server.properties