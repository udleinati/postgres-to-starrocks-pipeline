FROM denoland/deno:2.4.3 AS build

ARG APP_DIR

# Prefer not to run as root.
USER root
RUN apt update
RUN apt install -y curl libxml2

ARG HURL_VERSION=7.0.0
RUN curl -L -s https://github.com/Orange-OpenSource/hurl/releases/download/${HURL_VERSION}/hurl-${HURL_VERSION}-aarch64-unknown-linux-gnu.tar.gz | tar xvz -C /tmp
RUN mv /tmp/hurl-${HURL_VERSION}-aarch64-unknown-linux-gnu/bin/hurl /usr/local/bin/hurl

WORKDIR /app

COPY . .

RUN chown -R deno:deno /app

USER deno

RUN deno cache debezium/main.ts

CMD ["deno"]
