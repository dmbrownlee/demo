FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   openssh-client \
   runit \
   runit-init \
   sudo \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& chmod 4511 /usr/bin/sudo \
&& useradd -m -G sudo -s /bin/bash ansible \
&& echo 'password\npassword\n' | passwd ansible \
&& mkdir -p /etc/sv/console/log \
&& echo '#!/bin/sh -euC\n\
# Disable service, if /dev/tty{N} does not exist. See #914788.\n\
if ! test -c /dev/pts/0 ; then\n\
  rm /etc/service/console\n\
  exit 0\n\
fi\n\
\n\
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
   openssh-server \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir -p /etc/sv/ssh/log \
&& echo '#!/bin/sh\n\
if [ ! -d /run/sshd ]; then\n\
  mkdir -p /run/sshd\n\
fi\n\
/usr/sbin/sshd -D' > /etc/sv/ssh/run \
&& chmod 755 /etc/sv/ssh/run \
&& echo '#!/bin/sh -euC\n\
svlogd -tt .' > /etc/sv/ssh/log/run \
&& chmod 755 /etc/sv/ssh/log/run \
&& ln -s /etc/sv/ssh /etc/service/ssh


VOLUME [ "/root", "/usr", "/home" ]

EXPOSE 22

CMD ["/sbin/init"]
