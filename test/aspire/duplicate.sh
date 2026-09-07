#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "aspire CLI runs before reinstallation" \
aspire --version

# The CLI's duplicate scenario activates the feature with installCli=false and
# true. Re-run its staged installer with true to also exercise an existing CLI.
if [[ "$(id -u)" -eq 0 ]]; then
    check "aspire CLI can be reinstalled" \
    env INSTALLCLI=true bash .devcontainer/aspire/install.sh
else
    check "aspire CLI can be reinstalled" \
    sudo -H env INSTALLCLI=true bash .devcontainer/aspire/install.sh
fi

check "no separate .NET SDK is installed" \
bash -c "! command -v dotnet"

check "shared aspire CLI runs after reinstallation" \
/usr/local/bin/aspire --version

reportResults
