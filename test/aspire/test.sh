#!/usr/bin/env bash

set -e

# Run tests with `devcontainer features test -f aspire` in the parent of the src and test folders.

source dev-container-features-test-lib

check "aspire CLI is installed" \
command -v aspire

check "aspire CLI runs successfully" \
aspire --version

reportResults