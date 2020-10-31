FROM ubuntu:20.10

MAINTAINER dergeberl

RUN apt update && \
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
      mtr && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

ENTRYPOINT ["sleep", "infinity"]
