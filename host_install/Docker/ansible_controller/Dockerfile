FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   openssh-client \
   sudo \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& chmod 4511 /usr/bin/sudo \
&& useradd -m -G sudo -s /bin/bash user \
&& echo 'password\npassword\n' | passwd user

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   build-essential \
   curl \
   git \
   libffi-dev \
   libssl-dev \
   procps \
   python3 \
   python3-dev \
   python3-pip \
   python3-setuptools \
   software-properties-common \
   sshpass \
   tmux \
   vim \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1 \
&& update-alternatives --config python \
&& pip3 install wheel \
&& pip3 install cryptography netmiko napalm pyntc \
&& pip3 install --upgrade paramiko \
&& pip3 install ansible

COPY --chown=user:user labnetwork.setup /home/user/labnetwork.setup

COPY --chown=user:user myconfig.sh /home/user/.myconfig.sh

RUN chmod 755 /home/user/labnetwork.setup /home/user/.myconfig.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   dnsutils \
   iproute2 \
   iptables \
   iputils-ping \
   mtr \
   net-tools \
   telnet \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/*

VOLUME [ "/root", "/usr", "/home" ]

USER user

CMD [ "sh", "-c", "cd; exec bash -i" ]
