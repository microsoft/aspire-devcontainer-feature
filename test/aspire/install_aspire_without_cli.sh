#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "aspire CLI is not installed" \
bash -c "! command -v aspire"

reportResults
