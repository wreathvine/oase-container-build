#!/bin/bash

until mysqladmin -h${HOST_DB:-mariadb} -uroot -p${DB_ROOT_PASSWORD:-Ch@ngeMe} ping; do echo waiting for mysql ping response.; sleep 2; done
until mysql -h${HOST_DB:-mariadb} -uroot -p${DB_ROOT_PASSWORD:-Ch@ngeMe} -e 'SELECT 1'; do echo waiting for mysql service response.; sleep 2; done

cd /exastro/OASE/oase-root

if [ ! -e /exastro/OASE/oase-root/SETUP_DONE ]; then
    sed -i -e "/^        'HOST'     :/s/oase-mariadb/${DB_HOST:-mariadb}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
    sed -i -e "/^        'PORT'     :/s/3306/${DB_PORT:-3306}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
    sed -i -e "/^        'NAME'     :/s/OASE_DB/${DB_DATABASE:-OASE_DB}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
    sed -i -e "/^        'USER'     :/s/OASE_USER/${DB_USER:-OASE_USER}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
    sed -i -e "/^        'PASSWORD' :/s/OASE_PASSWD/${DB_PASSWORD:-Ch@ngeMe}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py

    python3 manage.py makemigrations web_app
    python3 manage.py migrate
    python3 manage.py loaddata init init_custom
    python3 manage.py create_initial_record 26 ${BUSINESS_CENTRAL_ENDPOINT:-business-central:8080} 0
    python3 manage.py create_initial_record 60 ${KIE_SERVER_ENDPOINT:-kie-server:8080} 0
    python3 manage.py create_initial_record 27 ${JBOSS_USER:-admin} 0
    python3 manage.py create_initial_record 28 ${JBOSS_PASSWORD:-admin} 1
    python3 manage.py create_initial_record 52 ${MQ_HOST:-rabbitmq} 0
    python3 manage.py create_initial_record 50 ${MQ_USER:-admin} 0
    python3 manage.py create_initial_record 51 ${MQ_PASSWORD:-Ch@ngeMe} 1
    python3 manage.py create_initial_record 31 ${MAIL_SMTP:-{}} 0

    touch /exastro/OASE/oase-root/SETUP_DONE
fi

exec "$@"
