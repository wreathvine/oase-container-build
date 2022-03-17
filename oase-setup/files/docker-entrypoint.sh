#!/bin/bash

cd /exastro/OASE/oase-root

sed -i -e "/^        'NAME'     :/s/OASE_DB/${MARIADB_DATABASE}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
sed -i -e "/^        'USER'     :/s/OASE_USER/${MARIADB_USER}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
sed -i -e "/^        'PASSWORD' :/s/OASE_PASSWD/${MARIADB_PASSWORD}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py

python3 manage.py makemigrations web_app
python3 manage.py migrate
python3 manage.py loaddata init init_custom
python3 manage.py create_initial_record 27 ${DROOLS_USER_NAME} 0
python3 manage.py create_initial_record 28 ${DROOLS_USER_PASSWORD} 1
python3 manage.py create_initial_record 50 ${RABBITMQ_USER} 0
python3 manage.py create_initial_record 51 ${RABBITMQ_PASSWORD} 1

exec "$@"
