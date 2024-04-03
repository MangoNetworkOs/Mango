#!/bin/sh
# Copyright (c) MangoNet Labs Ltd.
# SPDX-License-Identifier: Apache-2.0

# fast fail.
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
REPO_ROOT="$(git rev-parse --show-toplevel)"
DOCKERFILE="$DIR/Dockerfile"
GIT_REVISION="$(git describe --always --dirty --exclude '*')"
BUILD_DATE="$(date -u +'%Y-%m-%d')"

echo
echo "Building mgo-rosetta docker image"
echo "Dockerfile: \t$DOCKERFILE"
echo "docker context: $REPO_ROOT"
echo "build date: \t$BUILD_DATE"
echo "git revision: \t$GIT_REVISION"
echo

docker build -f "$DOCKERFILE" "$REPO_ROOT" \
  -t mangonetwork/mgo-rosetta-devnet \
	--build-arg GIT_REVISION="$GIT_REVISION" \
	--build-arg BUILD_DATE="$BUILD_DATE" \
	"$@"
