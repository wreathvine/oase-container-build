#!/bin/bash

#sed -i -e "/^        'NAME'     :/s/OASE_DB/${MARIADB_DATABASE}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
#sed -i -e "/^        'USER'     :/s/OASE_USER/${MARIADB_USER}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
#sed -i -e "/^        'PASSWORD' :/s/OASE_PASSWD/${MARIADB_PASSWORD}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py

exec "$@"
