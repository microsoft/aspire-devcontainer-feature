#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "no separate .NET SDK is installed" \
bash -c "! command -v dotnet"

check "aspire CLI is not installed" \
bash -c "! command -v aspire"

reportResults
