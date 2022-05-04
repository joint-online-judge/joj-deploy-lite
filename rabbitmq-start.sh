#!/bin/bash

set -e
set -u
set -x



(
    sleep 15;
    echo "rabbitmq startup events..."
    #rabbitmqctl wait --timeout 60 /var/lib/rabbitmq/mnesia/rabbitmq.pid
    rabbitmqctl start_app;
    rabbitmqctl await_startup;
    rabbitmqctl add_user $RABBITMQ_USERNAME $RABBITMQ_PASSWORD;
    rabbitmqctl set_user_tags $RABBITMQ_USERNAME administrator;
    rabbitmqctl add_vhost $RABBITMQ_VHOST;
    rabbitmqctl set_permissions -p $RABBITMQ_VHOST $RABBITMQ_USERNAME ".*" ".*" ".*";
) &

echo "starting rabbitmq..."
echo "management_agent.disable_metrics_collector = false" > /etc/rabbitmq/conf.d/management_agent.disable_metrics_collector.conf
rabbitmq-plugins enable --offline rabbitmq_management
rabbitmq-server $@


