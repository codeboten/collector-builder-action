#!/bin/bash -x

export GOARCH=$TARGETARCH
export CGO_ENABLED=0
export GOFLAGS=-buildvcs=false
export BUILD_PATH=./$2
mkdir -p ${BUILD_PATH}
chmod 777 ${BUILD_PATH}
echo "Building using /builder --config $1"
/builder --config $1 --output-path ${BUILD_PATH}/otelcolaction
chmod 755 ${BUILD_PATH}/otelcolaction

# time=$(date)
# echo "time=$time" >> $GITHUB_OUTPUT
