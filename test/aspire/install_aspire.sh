#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "aspire CLI is installed" \
command -v aspire

reportResults
