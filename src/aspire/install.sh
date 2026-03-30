#!/usr/bin/env bash

#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Maintainer: The Aspire team at https://github.com/microsoft/aspire

set -e
set -o pipefail

INSTALL_CLI="${INSTALLCLI:-"true"}"

echo "Activating feature 'Aspire'"

# Aspire bundles the .NET SDK it requires. Installing the CLI is all that is needed.
if [[ "${INSTALL_CLI,,}" == "true" ]]; then
    echo "Installing Aspire CLI..."

    # Ensure curl and ca-certificates are available (not present on minimal base images).
    if ! command -v curl &>/dev/null; then
        apt-get update -y
        apt-get install -y --no-install-recommends curl ca-certificates
    fi

    curl -sSL https://aspire.dev/install.sh | bash

    # The installer puts the binary at $HOME/.aspire/bin/aspire and only updates shell
    # profile files (e.g. ~/.bashrc). Create a symlink in /usr/local/bin so that aspire
    # is accessible in non-interactive shells (e.g. devcontainer test runner).
    ASPIRE_BIN="${HOME}/.aspire/bin/aspire"
    if [[ -f "${ASPIRE_BIN}" ]]; then
        ln -sf "${ASPIRE_BIN}" /usr/local/bin/aspire
    fi
fi

echo "... done activating feature 'Aspire'"
