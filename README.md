# multitool-container

![GitHub release](https://img.shields.io/github/v/release/dergeberl/multitool-container)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dergeberl/multitool-container/build-container)

Three containers with useful tools for troubleshooting. 

## basic container

This container has the following tools/packages installed:
- bash
- curl
- wget
- vim
- nano
- iputils-ping
- htop

The container image can be downloaded by ghrc.io and docker.io

`ghcr.io/dergeberl/multitool:latest`
`dergeberl/multitool:latest`

## network container

The following tools/packages are installed in this container in addition to the basic container:
- socat
- tcpdump
- dnsutils 
- nmap
- net-tools
- ethtool
- netcat-openbsd
- sysstat
- iftop
- iotop
- lsof
- mtr

The container image can be downloaded by ghrc.io and docker.io

`ghcr.io/dergeberl/multitool-net:latest`
`dergeberl/multitool-net:latest`

## kubectl container

The following tools/packages are installed in this container in addition to the basic container:
- kubectl

The container image can be downloaded by ghrc.io and docker.io

`ghcr.io/dergeberl/multitool-kubectl:latest`
`dergeberl/multitool-kubectl:latest`


All containers are available for the following arch:

- amd64 
- armv7
- arm64


## usage docker

```bash
docker run --rm -d --name multitool ghcr.io/dergeberl/multitool:latest
docker exec -it multitool /bin/bash
```

```bash
docker stop multitool
```

## usage kubernetes

```bash
kubectl run --image ghcr.io/dergeberl/multitool:latest multitool
kubectl exec multitool -it -- /bin/bash
```

```bash
kubectl delete pod multitool
```
