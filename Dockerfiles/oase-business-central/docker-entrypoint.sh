#!/bin/sh

$JBOSS_HOME/bin/add-user.sh -a --user ${DROOLS_USER_NAME} --password ${DROOLS_USER_PASSWORD} --role ${DROOLS_USER_ROLE}

exec "$@"