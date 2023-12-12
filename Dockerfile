FROM mikefarah/yq

USER root
RUN apk add --no-cache bash
USER yq
ENV OTELCOL_VERSION=$(yq '.dist.otelcol_version' $1)


FROM golang:latest as build

ARG TARGETARCH
ENV BUILDER_VERSION=${OTELCOL_VERSION:-0.86.0)

RUN curl -L -o /builder https://github.com/open-telemetry/opentelemetry-collector/releases/download/cmd%2Fbuilder%2Fv${BUILDER_VERSION}/ocb_${BUILDER_VERSION}_linux_${TARGETARCH}
RUN chmod +x /builder
WORKDIR /build

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
