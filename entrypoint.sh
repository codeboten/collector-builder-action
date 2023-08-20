#!/bin/bash -x

export GOARCH=$TARGETARCH
export CGO_ENABLED=0
export GOFLAGS=-buildvcs=false
mkdir -p ./$2
chmod a+r ./$2
echo "Building using /builder --config $1"
/builder --config $1 --output-path ./$2/otelcolaction

# time=$(date)
# echo "time=$time" >> $GITHUB_OUTPUT
