#!/usr/bin/env bash

#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/devcontainers/features/tree/main/src/dotnet
# Maintainer: The Aspire team at https://github.com/microsoft/aspire

set -e

# Set the current latest Aspire version here
ASPIRE_LATEST_VERSION="9.4.0"

# default to latest if not specified
VERSION="${VERSION:-"latest"}"
INSTALL_CLI="${INSTALLCLI:-"true"}"

# Acceptable versions: 9.x, 9.x.x, latest, latest-daily
if [[ ! $VERSION =~ ^(9\.[0-9]+(\.[0-9]+)?|latest|latest-daily)$ ]]; then
    echo "Error: VERSION must be a valid Aspire 9.x version (e.g., '9.1', '9.2.1'), 'latest', or 'latest-daily', not: '$VERSION'."
    exit 1
fi

# Map 'latest' to the current latest version
if [[ $VERSION == "latest" ]]; then
    VERSION="$ASPIRE_LATEST_VERSION"
fi

echo "Activating feature 'Aspire' version: $VERSION"

# Before Aspire 9.1 install required `dotnet workload`: this is no longer necessary, as Aspire is 
# installed when restoring Aspire projects. It's only necessary to install the appropriate version of the templates.

if [[ $VERSION == "latest-daily" ]]; then
    # https://github.com/microsoft/aspire/blob/main/docs/using-latest-daily.md
    dotnet nuget add source --name dotnet9 https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet9/nuget/v3/index.json

    # If you use Package Source Mapping, you'll also need to add the following mappings to your NuGet.config
    # <packageSourceMapping>
    #   <packageSource key="dotnet9">
    #     <package pattern="Aspire.*" />
    #     <package pattern="Microsoft.Extensions.ServiceDiscovery*" />
    #     <package pattern="Microsoft.Extensions.Http.Resilience" />
    #   </packageSource>
    # </packageSourceMapping>

    dotnet new install Aspire.ProjectTemplates::*-* --force
else
    dotnet new install --force Aspire.ProjectTemplates::$VERSION
fi

# Optionally install the Aspire CLI if requested
if [[ "${INSTALL_CLI,,}" == "true" ]]; then
    echo "Installing Aspire CLI (prerelease)..."
    curl -sSL https://aspire.dev/install.sh | bash
fi

echo "... done activating feature 'Aspire' version: $VERSION"
