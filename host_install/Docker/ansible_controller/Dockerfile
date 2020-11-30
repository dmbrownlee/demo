FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install telnet curl openssh-client vim \
iputils-ping build-essential libssl-dev libffi-dev python3-pip python3-dev \
python3-setuptools net-tools python3 software-properties-common iproute2 \
sshpass git tmux iptables \
&& update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1 \
&& update-alternatives --config python \
&& pip3 install wheel \
&& pip3 install cryptography netmiko napalm pyntc \
&& pip3 install --upgrade paramiko \
&& pip3 install ansible \
&& mkdir -m 0700 /root/.ssh \
&& chown -R root /root/.ssh/ \
&& echo "curl -fsSLo /root/.vimrc https://raw.githubusercontent.com/dmbrownlee/home/master/ansible/roles/baseline/templates/vimrc.j2" > /root/.getconfs \
&& echo "curl -fsSLo /root/.tmux.conf https://raw.githubusercontent.com/dmbrownlee/home/master/ansible/roles/baseline/templates/tmux.conf.j2" >> /root/.getconfs \
&& echo "cd /tmp && git clone https://github.com/dmbrownlee/demo.git && cp -a /tmp/demo/networkplus/labfiles/ansible ~" >> /root/.getconfs

VOLUME [ "/root", "/usr" ]
CP labnetwork.setup /root
CMD [ "sh", "-c", "cd; exec bash -i" ]
