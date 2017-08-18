# kafka-release

to test topic creation, producing and consuming from kafka run following command on kafka

```
export JAVA_HOME=/var/vcap/packages/jdk
export PATH=$JAVA_HOME/bin:$PATH
export KAFKA_OPTS="-Djava.security.auth.login.config=/var/vcap/jobs/kafka/config/kafka_client_jaas.conf"
cd /var/vcap/jobs/kafka/packages/kafka/kafka
bin/kafka-topics.sh --describe --zookeeper 192.168.111.21:2181 --topic test3
bin/kafka-topics.sh --create --zookeeper 192.168.111.21:2181 --replication-factor 3 --partitions 1 --topic test3
bin/kafka-topics.sh --describe --zookeeper 192.168.111.21:2181 --topic test3
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test3 --producer.config /var/vcap/jobs/kafka/config/client_ssl.properties
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 -topic test3 --from-beginning --consumer.config /var/vcap/jobs/kafka/config/client_ssl.properties
```
