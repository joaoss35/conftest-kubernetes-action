FROM alpine:3.13.5

RUN apk add --no-cache git wget bash jq coreutils ca-certificates tar

WORKDIR action

RUN wget https://github.com/instrumenta/conftest/releases/download/v0.25.0/conftest_0.25.0_Linux_x86_64.tar.gz && tar -xzf conftest_0.25.0_Linux_x86_64.tar.gz -C /tmp && \
    mv /tmp/conftest /usr/local/bin/conftest && rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
