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

    # Collect prerequisites that need to be installed.
    _PKGS=""
    # Ensure curl and ca-certificates are available (not present on minimal base images).
    if ! command -v curl &>/dev/null; then
        _PKGS="${_PKGS} curl ca-certificates"
    fi
    # The Aspire CLI is a .NET application and requires libicu at runtime.
    # Install it if not already present (minimal base images omit it by default).
    if ! ldconfig -p 2>/dev/null | grep -q 'libicudata'; then
        _PKGS="${_PKGS} libicu-dev"
    fi
    if [[ -n "${_PKGS}" ]]; then
        apt-get update -y
        # shellcheck disable=SC2086
        apt-get install -y --no-install-recommends ${_PKGS}
    fi

    curl -sSL https://aspire.dev/install.sh | bash

    # The installer puts the binary at $HOME/.aspire/bin/aspire and only updates shell
    # profile files (e.g. ~/.bashrc). Copy the binary to /usr/local/bin so that aspire
    # is accessible to all users in non-interactive shells (e.g. devcontainer test runner).
    # A symlink is intentionally NOT used: /root is mode 700, so non-root container users
    # (e.g. vscode) cannot follow a symlink that passes through /root.
    ASPIRE_BIN="${HOME}/.aspire/bin/aspire"
    if [[ -f "${ASPIRE_BIN}" ]]; then
        cp "${ASPIRE_BIN}" /usr/local/bin/aspire
        chmod 755 /usr/local/bin/aspire
    fi
fi

echo "... done activating feature 'Aspire'"
