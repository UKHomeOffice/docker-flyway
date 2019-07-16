FROM openjdk:8-jre-alpine

ENV FLYWAY_VERSION 5.2.4

RUN apk update && \
    apk upgrade && \
    apk add --update postgresql-client nss python py-pip ca-certificates gettext curl git bash openssl && \
    mkdir /source /flyway /schemas /docker && \
    cd /flyway && \
    wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz && \
    tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz && \
    mv flyway-${FLYWAY_VERSION}/* . && \
    rm flyway-commandline-${FLYWAY_VERSION}.tar.gz && \
    addgroup -S flyway && \
    adduser -D -G flyway -u 1000 -s /bin/bash -h /home/flyway flyway && \
    chown -R flyway:flyway /home/flyway /flyway /source /schemas /docker && \
    pip install --upgrade pip && \
    pip install yasha && \
    rm -rf /var/cache/apk/*

ENV PATH="/flyway:${PATH}"

WORKDIR /docker/
