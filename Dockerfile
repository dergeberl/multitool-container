FROM ubuntu:21.04

MAINTAINER dergeberl

LABEL org.opencontainers.image.source https://github.com/dergeberl/multitool-container

RUN apt update && \
      apt upgrade -y && \
      apt install -y --no-install-recommends  \
      bash \
      curl \
      wget \
      socat \
      tcpdump \
      dnsutils  \
      nmap \
      net-tools \
      ethtool \
      iputils-ping \
      netcat-openbsd \
      sysstat \
      vim \
      htop \
      mtr \
      ca-certificates && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg --output /etc/apt/trusted.gpg.d/k8s-apt-key.gpg && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
    apt update && apt install -y kubectl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

ENTRYPOINT ["sleep", "infinity"]
