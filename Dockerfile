ARG KUBECTL_TAG=v1.37.2@sha256:fe049faa65ae483ac200009a949a68fa4c9985daea12c9cb1195c9c7965301fc

### base container image
FROM ubuntu:26.04@sha256:065aa8626841f16057b78b027b464cd59c4fac36c204c72dcbf48d66f5fa8a96 AS base

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
FROM registry.k8s.io/kubectl:${KUBECTL_TAG} AS kubectl-source

FROM base AS kubectl

COPY --from=kubectl-source /bin/kubectl /usr/local/bin/kubectl

CMD ["sleep", "infinity"]
