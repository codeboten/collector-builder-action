FROM mikefarah/yq as metadata

USER root
RUN apk add --no-cache bash
USER yq
RUN yq '.dist.otelcol_version' $1 | tee /tmp/otelcol_version


FROM golang:latest as build

ARG TARGETARCH
ARG BUILDER_VERSION

COPY --from=metadata /tmp/otelcol_version /tmp/otelcol_version

ENV BUILDER_VERSION=$(if [ -s "/tmp/otelcol_version" ]; then cat /tmp/otelcol_version; else echo "0.86.0"; fi)

RUN curl -L -o /builder https://github.com/open-telemetry/opentelemetry-collector/releases/download/cmd%2Fbuilder%2Fv${BUILDER_VERSION}/ocb_${BUILDER_VERSION}_linux_${TARGETARCH}
RUN chmod +x /builder
WORKDIR /build

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
