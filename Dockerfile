### base container image
FROM ubuntu:24.04 AS base

MAINTAINER dergeberl

LABEL org.opencontainers.image.source https://github.com/dergeberl/multitool-container

COPY bash_aliases /root/.bash_aliases
COPY bash_banner /root/.bash_banner

RUN apt update && \
      apt upgrade -y && \
      apt install -y --no-install-recommends  \
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

RUN apt update && apt install -y gnupg2  && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' > /etc/apt/sources.list.d/kubernetes.list && \
    apt update && apt install -y kubectl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

ENTRYPOINT ["sleep", "infinity"]