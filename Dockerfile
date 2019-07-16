FROM boxfuse/flyway:5.2.4-alpine

RUN addgroup -S java && \
    adduser -D -G java -u 1000 -s /bin/bash -h /home/java java && \
    mkdir /docker /schemas && \
    chown -R java:java /home/java /flyway /docker /schemas

USER 1000

WORKDIR /docker
