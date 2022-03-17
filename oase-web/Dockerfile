ARG OASE_VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY

FROM exastro/oase-base:${OASE_VERSION} as resource
FROM httpd:2.4 as apache24

FROM python:3.6-slim

# Enviroments
ENV OASE_VERSION=${OASE_VERSION:-latest}
ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}
ENV HTTPD_VERSION=2.4.52
ENV HTTPD_PATCHES=
ENV HTTPD_SHA256=0127f7dc497e9983e9c51474bed75e45607f2f870a7675a86dc90af6d572f5c9
ENV HTTPD_PREFIX=/usr/local/apache2
ENV HOSTNAME=exastro-oase
ENV PATH=/usr/local/apache2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Copy OASE artifacts
COPY --chown=www-data:www-data --from=resource /exastro /exastro
COPY --chown=www-data:www-data --from=resource /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages/

# Copy Apache
COPY --from=apache24 /usr/local/apache2 /usr/local/apache2
COPY --from=apache24 /usr/local/bin/httpd-foreground /usr/local/bin/

# Install package
RUN apt-get update && apt-get install -y \
    python3-pip \
    libmariadb-dev \
    default-mysql-client \
    apache2-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir -r /exastro/OASE/oase_install_package/install_scripts/list/requirements.txt.org 

# Copy setting files
WORKDIR /usr/local/apache2/conf
COPY --chown=www-data:www-data ./files/oase.conf ./extra/
COPY --chown=www-data:www-data ./files/httpd.conf ./httpd.conf

EXPOSE 80

CMD ["httpd-foreground"]
