ARG OASE_VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY

FROM exastro/oase-base:${OASE_VERSION} as resource

FROM python:3.6-slim

ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}

# Environments
ENV OASE_ROOT_DIR=/exastro/OASE/oase-root
ENV RUN_INTERVAL=0
ENV PYTHON_MODULE=/usr/local/bin/python3
ENV LOG_LEVEL=NORMAL
ENV LOG_DIR=/exastro/OASE/oase-root/logs/backyardlogs/oase_action

# Add OASE user
RUN groupadd -g 49152 oase \
 && useradd -r -u 49152 -g oase oase

# Copy OASE artifacts
COPY --chown=oase:oase --from=resource /exastro /exastro/
COPY --chown=oase:oase --from=resource /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages/
COPY --chown=oase:oase ./files/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh

# Install packages
RUN apt-get update && apt-get install -y \
    default-mysql-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV http_proxy=
ENV https_proxy=

USER 49152
ENTRYPOINT ["/docker-entrypoint.sh"]