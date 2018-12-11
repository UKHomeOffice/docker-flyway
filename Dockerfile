FROM boxfuse/flyway:5.2.0-alpine

RUN addgroup -S java && \
    adduser -D -G java -u 1000 -s /bin/bash -h /home/java java && \
    chown -R java:java /home/java /flyway

USER 1000
