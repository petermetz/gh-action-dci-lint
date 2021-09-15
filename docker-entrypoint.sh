#!/bin/bash

echo "Request JSON:"
echo "$1"
echo "::lint-git-repo-request::Sending request to DCI Lint API..."

RESPONSE=`node /usr/src/app/node_modules/@dci-lint/cmd-api-server/dist/lib/main/typescript/cmd/dci-lint-cli.js lint-git-repo --request="$1"`
echo "DCI-Lint JSON Response:"
echo "$RESPONSE"

LINTER_EXIT_CODE=$?

LINTER_ERROR_COUNT=`echo $RESPONSE | jq -r '.linterErrors | length'`

echo "::set-output name=lint-git-repo-response::${RESPONSE//[$'\t\r\n ']}"
echo "::set-output name=lint-git-repo-error-count::$LINTER_ERROR_COUNT"

if [ "$LINTER_EXIT_CODE" -gt "0" ]; then
  echo "DCI-Lint exited with code $LINTER_EXIT_CODE. Failing the check..."
  exit 2
elif [ "$LINTER_ERROR_COUNT" -gt "0" ]; then
  echo "Found $LINTER_ERROR_COUNT linter errors. Failing the check..."
  exit 1
else
  echo "No linter errors found. Passing the check..."
  exit 0
fi
