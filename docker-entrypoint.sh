#!/bin/bash

set -e

echo "$(env)"
echo "=========="
echo "$1"
echo "::lint-git-repo-request::Sending request to DCI Lint API..."

RESPONSE=$(node \
  /usr/src/app/node_modules/@dci-lint/cmd-api-server/dist/lib/main/typescript/cmd/dci-lint-cli.js \
  lint-git-repo \
  --request="$1")

echo "::set-output name=lint-git-repo-response::$RESPONSE"