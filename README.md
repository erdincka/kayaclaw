# Kayaclaw

Nemoclaw running inside Kubernetes

## Build Image

`kubectl apply -f image-builder.yaml`

## Deploy Nemoclaw

`kubectl apply -f kayaclaw.yaml`

# Remove

`kubectl delete -f kayaclaw.yaml`
`kubectl delete -f image-builder.yaml`

# TODO

- Fix overlay
- Try using nemoclaw to deploy openshell/claw containers directly onto individual pods?
- 
