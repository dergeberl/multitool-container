# multitool-container

![GitHub release](https://img.shields.io/github/v/release/dergeberl/multitool-container)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dergeberl/multitool-container/container.yml?branch=main)

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
docker run --rm -it --name multitool ghcr.io/dergeberl/multitool:latest /bin/bash
```

## usage kubernetes

```bash
kubectl run -i --tty --image ghcr.io/dergeberl/multitool:latest multitool -- /bin/bash
```

