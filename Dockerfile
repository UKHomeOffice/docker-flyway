FROM openjdk:8-jre-alpine

ENV FLYWAY_VERSION 6.3.3

RUN apk update && \
    apk upgrade && \
    apk add --update postgresql-client nss python py-pip ca-certificates openssh gettext curl git bash openssl gnupg && \
    mkdir /source /flyway /schemas /docker /root/.ssh && \
    cd /flyway && \
    wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz && \
    tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz && \
    mv flyway-${FLYWAY_VERSION}/* . && \
    rm flyway-commandline-${FLYWAY_VERSION}.tar.gz && \
    addgroup -S flyway && \
    adduser -D -G flyway -u 1000 -s /bin/bash -h /home/flyway flyway && \
    mkdir -p /home/flyway/.ssh && \
    chown -R flyway:flyway /home/flyway /flyway /source /schemas /docker && \
    chmod 600 /home/flyway/.ssh /root/.ssh && \
    pip install --upgrade pip && \
    pip install yasha && \
    rm -rf /var/cache/apk/*

COPY mssql.sh .
RUN ./mssql.sh

ADD create_ssh_key.sh /usr/bin/create_ssh_key.sh
RUN chmod +x /usr/bin/create_ssh_key.sh

ENV PATH="/flyway:${PATH}"

WORKDIR /docker/
