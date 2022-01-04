FROM debian:10.11
ARG username
ARG password
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   ssh \
   sudo \
   runit \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& chmod 4511 /usr/bin/sudo \
&& useradd -m -G sudo -s /bin/bash $username \
&& echo "$password\n$password\n" | passwd $username \
&& mkdir -p /run/sshd \
&& mkdir -p /var/log/svlogd/sshd \
&& mkdir -p /etc/sv/sshd/log 

COPY --chown=root:root files/boot.sh /sbin/boot.sh
COPY --chown=root:root files/sshd.runit /etc/sv/sshd/run
COPY --chown=root:root files/sshd-log.runit /etc/sv/sshd/log/run

RUN chmod 755 /sbin/boot.sh /etc/sv/sshd/run /etc/sv/sshd/log/run \
&& ln -s /etc/sv/sshd /etc/runit/runsvdir/default/sshd

EXPOSE 22

CMD ["/sbin/boot.sh"]
