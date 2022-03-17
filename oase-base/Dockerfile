ARG OASE_VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY

FROM python:3.6

ENV OASE_VERSION=${OASE_VERSION:-latest}
ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}

# Clone OASE artifacts
RUN mkdir /exastro
WORKDIR /exastro
RUN if [ "${OASE_VERSION}" = "latest" ]; then \
      echo "OASE_VERSION: ${OASE_VERSION}"; \
      git clone --depth=1 --single-branch https://github.com/exastro-suite/oase.git \
      OASE; \
    else \
      echo "OASE_VERSION: ${OASE_VERSION}"; \
      git clone --depth=1 --single-branch https://github.com/exastro-suite/oase.git \
      -b Exastro-OASE-${OASE_VERSION} OASE; \
    fi \
    && rm -rf /exastro/OASE/.git* /exastro/OASE/oase_documents

# Configuration
RUN sed -i.org '/mod_wsgi/d' /exastro/OASE/oase_install_package/install_scripts/list/requirements.txt
RUN cp /exastro/OASE/oase-root/confs/frameworkconfs/settings.py.sample /exastro/OASE/oase-root/confs/frameworkconfs/settings.py
RUN sed -i -e '/^SESSION_ENGINE/s/.*/SESSION_ENGINE = '\''django.contrib.sessions.backends.file'\''/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#SESSION_FILE_PATH/SESSION_FILE_PATH/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#EVTIMER_SERVER/EVTIMER_SERVER/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#    "type"/    "type"/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#    "protocol" : "https:"/    "protocol" : "http:"/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#    "location" : "127.0.0.1"/    "location" : "oase-web:80"/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#    "path"/    "path"/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e 's/^#}/}/g' /exastro/OASE/oase-root/confs/frameworkconfs/settings.py \
 && sed -i -e "/^        'HOST'     :/s/127.0.0.1/oase-mariadb/g" /exastro/OASE/oase-root/confs/frameworkconfs/settings.py

# Install Python packages
RUN pip install --no-cache-dir -r /exastro/OASE/oase_install_package/install_scripts/list/requirements.txt

RUN groupadd -g 49152 oase \
 && useradd -r -u 49152 -g oase oase

ENV http_proxy=
ENV https_proxy=

USER 49152
