FROM debian:latest
ARG username
ARG password
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   apt-utils \
   openssh-client \
   runit \
   runit-init \
   sudo \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* \
&& chmod 4511 /usr/bin/sudo \
&& useradd -m -G sudo -s /bin/bash $username \
&& echo "$password\n$password\n" | passwd $username \
&& mkdir -p /etc/sv/console/log \
&& echo '#!/bin/sh -euC\n\
# Disable service, if /dev/tty{N} does not exist. See #914788.\n\
if ! test -c /dev/pts/0 ; then\n\
  rm /etc/service/console\n\
  exit 0\n\
fi\n\
\n\
chown root:root /usr/bin/sudo\n\
chmod 4511 /usr/bin/sudo\n\
pgrep -x getty -t pts/0 && exit 163\n\
pgrep -x agetty -t pts/0 && exit 163\n\
! type fgetty >/dev/null 2>&1 || exec chpst -P fgetty pts/0\n\
exec /usr/bin/chpst -P getty pts/0 linux\n' > /etc/sv/console/run \
&& chmod 755 /etc/sv/console/run \
&& echo '#!/bin/sh -euC\n\
svlogd -tt .' > /etc/sv/console/log/run \
&& chmod 755 /etc/sv/console/log/run \
&& ln -s /etc/sv/console /etc/service/console

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   build-essential \
   cargo \
   curl \
   git \
   libffi-dev \
   libssl-dev \
   procps \
   python3 \
   python3-dev \
   python3-pip \
   python3-setuptools \
   rustc \
   software-properties-common \
   sshpass \
   tmux \
   vim \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* \
&& update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1 \
&& update-alternatives --config python \
&& pip3 install --no-cache-dir wheel \
&& pip3 install --no-cache-dir cryptography netmiko napalm pyntc \
&& pip3 install --no-cache-dir --upgrade paramiko \
&& pip3 install --no-cache-dir ansible \
&& apt-get purge -y rustc cargo

COPY --chown=$username:$username files/setup /home/$username/setup

COPY --chown=$username:$username files/myconfig.sh /home/$username/.myconfig.sh

RUN chmod 755 /home/$username/setup /home/$username/.myconfig.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   dnsutils \
   iproute2 \
   iptables \
   iputils-ping \
   mtr \
   net-tools \
   telnet \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/*

VOLUME [ "/root", "/usr", "/home" ]

CMD ["/sbin/init"]
