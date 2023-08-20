#!/bin/bash -x

export GOARCH=$TARGETARCH
export CGO_ENABLED=0
export GOFLAGS=-buildvcs=false
echo "Building using /builder --config $1"
/builder --config $1

# time=$(date)
# echo "time=$time" >> $GITHUB_OUTPUT
