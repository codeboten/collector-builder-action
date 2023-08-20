#!/bin/bash -x

export GOARCH=$TARGETARCH
export CGO_ENABLED=0
echo "Building using /builder --config $1"
/builder --config $1

# time=$(date)
# echo "time=$time" >> $GITHUB_OUTPUT
