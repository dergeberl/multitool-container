# multitool-container
a container with useful tools for troubleshooting

This images is available for the following arch:

- amd64 
- armv7
- arm64


## usage docker

```bash
docker run --rm -d --name multitool ghcr.io/dergeberl/multitool:main
docker exec -it multitool /bin/bash
```

```bash
docker stop multitool
```

## usage kubernetes

```bash
kubectl run --image ghcr.io/dergeberl/multitool:main multitool
kubectl exec multitool -it -- /bin/bash
```

```bash
kubectl delete pod multitool
```