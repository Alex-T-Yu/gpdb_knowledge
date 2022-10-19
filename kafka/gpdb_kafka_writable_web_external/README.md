# GPDB - KAFKA Writable External Web Table

Publish data to kafka. (GPDB to Kafka, Using External Web Table)

## Prerequirement
1. Install Kafka Client. (Require. All Master and Segment Node)

## How to deploy and use

### Deploy
```shell script
gpssh -h hostfile -v -e 'mkdir /data/shell/'
gpscp -h hostfile ./env.sh =:/data/shell/
gpscp -h hostfile ./publish =:/data/shell/
```

### Modify Configration File (env.sh)
```shell
# Input KAFKA Client path
# ex) KAFKA_CLIENT_HOME=/data/kafka/kafka_2.13-2.8.0
KAFKA_CLIENT_HOME=

# Input KAFKA BROKER (End Point)
# ex) KAFKA_DEFULT_BROKER=mdw:9092
KAFKA_DEFULT_BROKER=
```

### Use
```sql

CREATE WRITABLE EXTERNAL WEB TABLE wew_kafka_test (
	a text,
	b text,
	c text
)
EXECUTE '/data/shell/publish.sh -b <broker_host:port> -t <topic_name>' ON ALL
FORMAT 'CSV' ( delimiter ',' null '' escape '"' quote '"' )
ENCODING 'UTF8';

insert into wew_kafka_test values ('a', 'b,c', 'd'), ('x', 'y', 'z');

```