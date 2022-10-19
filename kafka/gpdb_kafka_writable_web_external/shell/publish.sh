#/bin/bash
. ./env.sh

broker=$KAFKA_DEFULT_BROKER
topic=

print_usage() {
  echo "Usage: publish.sh -b <broker_host:port> -t <topic_name>"
}

if [ $# -gt 1 ] ; then

        while getopts 't:b:' flag; do
        case "${flag}" in
                t) topic="${OPTARG}" ;;
                b) broker="${OPTARG}" ;;
                *) print_usage
                exit 1 ;;
        esac
        done
else
        print_usage
        exit 1;

fi

if [ -z $broker ] ; then
        echo "Invaild Broker. Check env.sh"
        exit 1;
fi

if [ -z $topic ] ; then
        echo "Invaild Topic."
        print_usage
        exit 1;
fi

$KAFKA_CLIENT_HOME/kafka-console-producer.sh --broker-list $broker --topic $topic < /dev/stdin


