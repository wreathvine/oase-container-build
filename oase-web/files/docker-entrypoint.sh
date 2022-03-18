#!/bin/bash

sed -i -e "/^        'HOST'     :/s/oase-mariadb/${DB_HOST:-mariadb}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
sed -i -e "/^        'PORT'     :/s/3306/${DB_PORT:-3306}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
sed -i -e "/^        'NAME'     :/s/OASE_DB/${DB_DATABASE:-OASE_DB}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
sed -i -e "/^        'USER'     :/s/OASE_USER/${DB_USER:-OASE_USER}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
sed -i -e "/^        'PASSWORD' :/s/OASE_PASSWD/${DB_PASSWORD:-Ch@ngeMe}/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py

exec "$@"
