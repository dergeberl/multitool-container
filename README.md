# multitool-container

![GitHub release](https://img.shields.io/github/v/release/dergeberl/multitool-container)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dergeberl/multitool-container/container.yml?branch=main)

Three containers with useful tools for troubleshooting. All container images are based on **Ubuntu**.

All containers are available for the following architectures:

- amd64 
- armv7
- arm64

## Basic Container

This container has the following tools/packages installed:
- bash
- curl
- wget
- vim
- nano
- iputils-ping
- htop

The container image can be downloaded from ghcr.io and docker.io:

`ghcr.io/dergeberl/multitool:latest`
`dergeberl/multitool:latest`

## Network Container

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

The container image can be downloaded from ghcr.io and docker.io:

`ghcr.io/dergeberl/multitool-net:latest`
`dergeberl/multitool-net:latest`

## Kubectl Container

The following tools/packages are installed in this container in addition to the basic container:
- kubectl

The container image can be downloaded from ghcr.io and docker.io:

`ghcr.io/dergeberl/multitool-kubectl:latest`
`dergeberl/multitool-kubectl:latest`

## Usage: Docker
```bash
docker run --rm -it --name multitool ghcr.io/dergeberl/multitool:latest /bin/bash
```

## Usage: Kubernetes

```bash
kubectl run -i --tty --image ghcr.io/dergeberl/multitool:latest multitool -- /bin/bash
```

### Ephemeral Container (`kubectl debug`)

Start an ephemeral container in an existing pod with the `kubectl debug` command. 
Check out the Kubernetes docs: https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-containers

The following command adds an ephemeral container running `bash`:
```bash
kubectl debug -iq --image=ghcr.io/dergeberl/multitool:latest <podname> -- /bin/bash
```

The following command adds an ephemeral container running `tcpdump` and pipes the output directly to `wireshark`:
```bash
kubectl debug -iq --image=ghcr.io/dergeberl/multitool-net:latest <podname> -- tcpdump -i any -w - |  wireshark -k -i -
```

### Node-Shell (`kubectl debug`)

You can also use the multitool container as a node-shell to debug a Kubernetes node:
```bash
kubectl debug node/<nodename> -it --image=ghcr.io/dergeberl/multitool --profile=sysadmin --quiet -- chroot /host /bin/bash
```

> Note: On some nodes, `/bin/bash` may not be available. If the command fails, try using `/bin/sh` instead.