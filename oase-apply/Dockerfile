ARG OASE_VERSION

FROM exastro/oase-backyard:${OASE_VERSION}

ARG OASE_VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV OASE_VERSION=${OASE_VERSION}
ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}

# Environments
ENV M2_HOME=/opt/apache-maven
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV CLASSPATH=$JAVA_HOME/lib
ENV PATH=$PATH:/opt/apache-maven/bin:$JAVA_HOME/bin

# Fixed oase_apply.py for container
COPY --chown=oase:oase ./files/oase_apply.py /exastro/OASE/oase-root/backyards/apply_driver/
COPY --chown=oase:oase ./files/settings.xml /home/oase/.m2/

USER root

# Install packages
RUN apt-get update && apt-get install -y \
    curl \
    default-mysql-client \
    openjdk-11-jdk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install maven packages
WORKDIR /tmp
RUN curl -k -LO https://archive.apache.org/dist/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz \
 && tar xvzf apache-maven-3.6.1-bin.tar.gz \
 && mv apache-maven-3.6.1 /opt/ \
 && ln -s /opt/apache-maven-3.6.1 /opt/apache-maven \
 && mkdir -p /home/oase/.m2/repository
WORKDIR /home/oase/.m2/repository
RUN echo "OASE_VERSION: ${OASE_VERSION}"
RUN curl -k -LO "https://github.com/exastro-suite/oase/releases/download/${OASE_VERSION}/oase_maven-${OASE_VERSION}.tar.gz" \
 && tar xvzf oase_maven-${OASE_VERSION}.tar.gz \
 && chown -R oase:oase /home/oase \
 && rm oase_maven-${OASE_VERSION}.tar.gz

WORKDIR /exastro/OASE/oase-root

ENV http_proxy=
ENV https_proxy=

USER 49152
EXPOSE 50001

CMD ["python3", "/exastro/OASE/oase-root/backyards/apply_driver/oase_apply.py"]

