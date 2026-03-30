#!/usr/bin/env bash

#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Maintainer: The Aspire team at https://github.com/microsoft/aspire

set -e

INSTALL_CLI="${INSTALLCLI:-"true"}"

echo "Activating feature 'Aspire'"

# Aspire bundles the .NET SDK it requires. Installing the CLI is all that is needed.
if [[ "${INSTALL_CLI,,}" == "true" ]]; then
    echo "Installing Aspire CLI..."
    curl -sSL https://aspire.dev/install.sh | bash
fi

echo "... done activating feature 'Aspire'"
