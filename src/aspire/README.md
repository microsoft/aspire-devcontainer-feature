
# Aspire (aspire)

Installs Aspire. See https://aspire.dev

## Example Usage

```json
"features": {
    "ghcr.io/microsoft/aspire-devcontainer-feature/aspire:3": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installCli | Whether to install the Aspire CLI. | boolean | true |

## Customizations

### VS Code Extensions

- `microsoft-aspire.aspire-vscode`
- `ms-azuretools.vscode-bicep`
- `GitHub.copilot-chat`
- `GitHub.copilot`

## Language-specific tooling

This feature installs the Aspire CLI and shared Aspire, Bicep, and GitHub Copilot VS Code extensions and port-forwarding settings. A separate .NET SDK is not required.

Language-specific SDKs and editor extensions should be selected by the consuming devcontainer configuration or template preset. Starting with feature version 3, this feature no longer automatically installs C# Dev Kit (`ms-dotnettools.csdevkit`). C# presets that need it should add it explicitly to `customizations.vscode.extensions`.

Set `installCli` to `false` to apply only the shared editor configuration without installing the Aspire CLI. Workloads that need additional SDKs or runtimes should configure those separately.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/microsoft/aspire-devcontainer-feature/blob/main/src/aspire/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
