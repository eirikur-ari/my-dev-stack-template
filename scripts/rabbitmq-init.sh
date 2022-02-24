#!/bin/sh

( sleep 10 ; \

# Guest can not login remotely after changes, thus we delete the guest user 
rabbitmqctl delete_user guest ; \

# Create a new local admin user
rabbitmqctl add_user admin admin ; \
rabbitmqctl set_user_tags admin administrator ; \
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*" ; \

# Create new virtual host
rabbitmqctl add_vhost test; \

# Create the test user for the test vhost
rabbitmqctl add_user test_user password ; \
rabbitmqctl set_permissions -p test test_user ".*" ".*" ".*" ; \
rabbitmqctl set_permissions -p test admin ".*" ".*" ".*" ; \

) &
rabbitmq-server $@
