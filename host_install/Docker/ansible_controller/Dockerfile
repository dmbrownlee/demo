FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install telnet curl openssh-client vim \
iputils-ping build-essential libssl-dev libffi-dev python3-pip python3-dev \
python3-setuptools net-tools python3 software-properties-common \
&& update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1 \
&& update-alternatives --config python \
&& pip3 install wheel \
&& pip3 install cryptography netmiko napalm pyntc \
&& pip3 install --upgrade paramiko \
&& pip3 install ansible

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install sshpass git tmux iptables \
procps dnsutils mtr iproute2 sudo

RUN mkdir -m 0700 /root/.ssh \
&& chown -R root /root/.ssh/ \
&& useradd -m -G sudo user \
&& echo 'password\npassword\n' | passwd user

COPY --chown=user:user labnetwork.setup /home/user/labnetwork.setup

COPY --chown=user:user myconfig.sh /home/user/.myconfig.sh

RUN chmod 755 /home/user/labnetwork.setup /home/user/.myconfig.sh

VOLUME [ "/root", "/usr", "/home" ]

USER user

CMD [ "sh", "-c", "cd; exec bash -i" ]
