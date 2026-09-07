const assert = require("node:assert/strict");
const feature = require("../../src/aspire/devcontainer-feature.json");

assert.deepEqual(feature.customizations.vscode.extensions, [
    "microsoft-aspire.aspire-vscode",
    "ms-azuretools.vscode-bicep",
    "GitHub.copilot-chat",
    "GitHub.copilot"
], "The shared feature must not inject language-specific editor tooling.");

assert.deepEqual(feature.customizations.vscode.settings, {
    "remote.autoForwardPorts": true,
    "remote.autoForwardPortsSource": "hybrid",
    "remote.otherPortsAttributes": {
        "onAutoForward": "ignore"
    }
}, "The shared port-forwarding settings must be preserved.");

assert.equal(
    Object.keys(feature.dependsOn ?? {}).some(id => /(^|\/)dotnet(:|$)/.test(id)),
    false,
    "The feature must not require the separate .NET SDK feature."
);

console.log("Language-neutral feature metadata checks passed.");
