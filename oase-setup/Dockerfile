ARG OASE_VERSION

FROM exastro/oase-base:${OASE_VERSION} as resource

FROM python:3.6-slim

# Environments
ENV MARIADB_DATABASE: ${MARIADB_DATABASE}
ENV MARIADB_USER: ${MARIADB_USER}
ENV MARIADB_PASSWORD: ${MARIADB_PASSWORD}

RUN groupadd -g 49152 oase \
 && useradd -r -u 49152 -g oase oase

# Copy OASE artifacts
COPY --chown=oase:oase --from=resource /exastro /exastro/
COPY --chown=oase:oase --from=resource /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages/

# Install packages
RUN apt-get update && apt-get install -y \
    default-mysql-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# oase-base
COPY --chown=oase:oase ./files/docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=oase:oase ./files/create_initial_record.py /exastro/OASE/oase-root/web_app/management/commands/
COPY --chown=oase:oase ./files/init_custom.yaml /exastro/OASE/oase-root/web_app/fixtures/
COPY --chown=oase:oase ./files/__init__.py /exastro/OASE/oase-root/web_app/models/

RUN chmod a+x /docker-entrypoint.sh

USER 49152

ENTRYPOINT ["/docker-entrypoint.sh"]
