### base container image
FROM ubuntu:26.04 AS base

LABEL org.opencontainers.image.authors="dergeberl"
LABEL org.opencontainers.image.source=https://github.com/dergeberl/multitool-container

COPY bash_aliases /root/.bash_aliases
COPY bash_banner /root/.bash_banner

RUN apt-get update && \
      apt-get upgrade -y && \
      apt-get install -y --no-install-recommends  \
      ca-certificates \
      bash \
      curl \
      wget \
      vim \
      nano \
      htop \
      iputils-ping && \
    echo "cat ~/.bash_banner" >> /root/.bashrc && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

CMD ["sleep", "infinity"]


### nettools container image
FROM base AS net

RUN apt-get update && \
      apt-get install -y --no-install-recommends  \
      socat \
      tcpdump \
      dnsutils  \
      nmap \
      net-tools \
      ethtool \
      netcat-openbsd \
      sysstat \
      iftop \
      iotop \
      lsof \
      mtr && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

CMD ["sleep", "infinity"]


### kubectl container image
FROM base AS kubectl

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends gnupg2 apt-transport-https && \
    K8S_MINOR_VERSION=$( \
      curl --retry 3 --retry-all-errors --retry-delay 5 -fsSL -H "Accept: application/vnd.github+json" https://api.github.com/repos/kubernetes/kubernetes/releases/latest | grep -oE '"tag_name": "v[0-9]+\.[0-9]+' | grep -oE 'v[0-9]+\.[0-9]+' || \
      curl --retry 3 --retry-all-errors --retry-delay 5 -fsSL https://cdn.dl.k8s.io/release/stable.txt | grep -oE '^v[0-9]+\.[0-9]+' || \
      curl --retry 3 --retry-all-errors --retry-delay 5 -fsSL https://dl.k8s.io/release/stable.txt | grep -oE '^v[0-9]+\.[0-9]+' \
    ) && \
    test -n "$K8S_MINOR_VERSION" && \
    key_ok=0 && \
    for _attempt in 1 2 3 4 5; do \
      if curl --retry 3 --retry-all-errors --retry-delay 5 -fsSL -o /tmp/kubernetes-release.key "https://pkgs.k8s.io/core:/stable:${K8S_MINOR_VERSION}/deb/Release.key" && test -s /tmp/kubernetes-release.key; then \
        key_ok=1 && break; \
      fi; \
      sleep 15; \
    done && \
    test "$key_ok" = 1 && \
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg /tmp/kubernetes-release.key && \
    rm -f /tmp/kubernetes-release.key && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:${K8S_MINOR_VERSION}/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y --no-install-recommends kubectl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

CMD ["sleep", "infinity"]
