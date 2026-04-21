# Nemoclaw on PCAI

Use with care!!

## Deploy

### Simple Installation

- Use 'Import Framework' in PCAI UI

- Provide [openclaw.png](./openclaw.png) as icon

- Provide [nemoclaw-0.1.0.tgz](./nemoclaw-0.1.0.tgz) as helm package

- Provide namespace (nemoclaw)

- Configure for your endpoint and settings, see [values](./.values.example) for examples.

- Wait ~5-10 minutes (depending on internet speed to download packages)

- It should be available on the configured endpoint

### Manual Installation (Using helm)

- Update `.values` file with the correct endpoint and token (use `.values.example` as a template).

- Deploy using helm

```bash
helm install nemo -n nemoclaw --create-namespace helm --values .values
```

#### Remove

```bash
helm uninstall -n nemoclaw nemo
```

## NOTES

Sandbox container logs:

```shell
  Status:      nemoclaw ai-assistant status
  Logs:        nemoclaw ai-assistant logs --follow

  OpenClaw UI (tokenized URL; treat it like a password)
  Port 18789 must be forwarded before opening this URL.
  http://127.0.0.1:18789/#token=???????????????
  https://claw.<your.domain>/#token=??????????????
  ──────────────────────────────────────────────────

  ...

  Your OpenClaw Sandbox is live.
  Sandbox in, break things, and tell us what you find.

  Next:
  $ source /root/.bashrc
  $ nemoclaw ai-assistant connect
  sandbox@ai-assistant$ openclaw tui

  GitHub  https://github.com/nvidia/nemoclaw
  Docs    https://docs.nvidia.com/nemoclaw/latest/
```

## Debugging

Connect to the workspace container:

```bash
kubectl exec -it -n nemoclaw <workspace-pod-name> -- bash
```

```shell
    # List available sandboxes
    nemoclaw list
    # Check sandbox status
    nemoclaw ai-assistant status
    # Check sandbox logs
    nemoclaw ai-assistant logs
    # Check openshell status
    openshell status
    # List available sandboxes
    openshell sandbox list
    # Get inference status
    openshell inference get
    # List available models from endpoint
    curl -s http://localhost:8000/v1/models
    # List port forwarding
    openshell forward list
    # Stop port forwarding if it is disconnected
    openshell forward stop 18789 ai-assistant 
    # If port forwarding not running
    openshell forward start --background 0.0.0.0:18789 ai-assistant
    # Connect to the sandbox
    nemoclaw ai-assistant connect
```

Inside the openclaw shell:

```shell
    # List available models from endpoint
    curl -s https://inference.local/v1/models
    # Open TUI
    openclaw tui
    # Test the agent
    openclaw agent --agent main -m "What is 7 times 8?"
    # Should respond with 56
```


## TODO

- [ ] Add multiple sandboxes

- [X] Fix allowedOrigins (or wait for new release).

  ~~Until then, use `kubectl port-forward -n nemoclaw <workspace-pod-name> 18789:18789` to access the UI. Get pod name using `kubectl get pods -n nemoclaw`. Get token from workspace pod logs using `kubectl logs -n nemoclaw <workspace-pod-name> -c workspace | grep token`.~~

## Import Framework via CLI

Directly deploy EzAppConfig (edit `nemoclaw-ezapp.yaml` if you want to change these):

- Uses `nemoclaw` namespace
- Uses `claw` as release name and openclaw sandbox/agent name
- Uses `ollama.ollama.svc:11434` as endpoint
- Uses `gemma4:26b` as model
- Uses `nemoclaw.${DOMAIN_NAME}` as HTTPS endpoint

First, upload the helm chart to chartmuseum. Replace the pod name accordingly.

```bash
kubectl port-forward -n ez-chartmuseum-ns pods/chartmuseum-7d4dd5f974-7hfs4 8080:8080&
curl -X POST http://localhost:8080/api/charts --data-binary "@nemoclaw-0.1.0.tgz"
kill %1
```

Then deploy the EzAppConfig.

```bash
kubectl apply -f nemoclaw-ezapp.yaml
```
