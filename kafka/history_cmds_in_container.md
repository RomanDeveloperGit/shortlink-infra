# Создание топика links.events
/opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --create \
  --topic links.events \
  --partitions 3 \
  --replication-factor 1 \
  --config retention.ms=604800000

# Увеличение количества партиций для наилучшего распараллеливания
  <!-- /opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --alter \
  --topic links.events \
  --partitions 100 -->




# Создание пользователя для сервиса link-api
/opt/kafka/bin/kafka-configs.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --alter \
  --add-config 'SCRAM-SHA-512=[password=link-api-secret]' \
  --entity-type users \
  --entity-name test

/opt/kafka/bin/kafka-acls.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --add \
  --allow-principal User:test \
  --operation Write \
  --topic links.events



# Создание пользователя для сервиса analytics
/opt/kafka/bin/kafka-configs.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --alter \
  --add-config 'SCRAM-SHA-512=[password=analytics-consumer-secret]' \
  --entity-type users \
  --entity-name analytics-consumer

/opt/kafka/bin/kafka-acls.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --add \
  --allow-principal User:analytics-consumer \
  --operation Read \
  --topic links.events

/opt/kafka/bin/kafka-acls.sh \
  --bootstrap-server shortlink-kafka:9092 \
  --add \
  --allow-principal User:analytics-consumer \
  --operation Describe \
  --topic links.events
