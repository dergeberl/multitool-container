### base container image
FROM ubuntu:21.10 AS base

MAINTAINER dergeberl

LABEL org.opencontainers.image.source https://github.com/dergeberl/multitool-container

RUN apt update && \
      apt upgrade -y && \
      apt install -y --no-install-recommends  \
      bash \
      curl \
      wget \
      vim \
      nano \
      htop \
      iputils-ping && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

ENTRYPOINT ["sleep", "infinity"]


### nettools container image
FROM base AS net

RUN apt update && \
      apt install -y --no-install-recommends  \
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

ENTRYPOINT ["sleep", "infinity"]


### kubectl container image
FROM base AS kubectl

RUN apt update && \
      apt install -y --no-install-recommends  \
      ca-certificates && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg --output /etc/apt/trusted.gpg.d/k8s-apt-key.gpg && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
    apt update && apt install -y kubectl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

ENTRYPOINT ["sleep", "infinity"]
