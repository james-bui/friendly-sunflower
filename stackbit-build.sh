#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e45f98f7de250001a1b3eda/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e45f98f7de250001a1b3eda 
fi
curl -s -X POST https://api.stackbit.com/project/5e45f98f7de250001a1b3eda/webhook/build/ssgbuild > /dev/null
jekyll build

curl -s -X POST https://api.stackbit.com/project/5e45f98f7de250001a1b3eda/webhook/build/publish > /dev/null
