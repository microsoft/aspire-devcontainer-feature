#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "no separate .NET SDK is installed" \
bash -c "! command -v dotnet"

check "aspire CLI is installed" \
command -v aspire

check "aspire CLI runs successfully" \
aspire --version

reportResults
