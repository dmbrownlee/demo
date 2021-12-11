FROM alpine:latest
ARG username
ARG password

RUN apk add --no-cache sudo
RUN apk add --no-cache openssh-server
RUN apk add --no-cache runit

RUN apk add --no-cache bash \
&& addgroup $username \
&& adduser -h /home/$username -G $username -s /bin/bash -D $username \
&& echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$username \
&& echo -e "$password\n$password\n" | passwd $username \
&& mkdir -p /run/sshd \
&& mkdir -p /var/log/svlogd/sshd \
&& mkdir -p /etc/sv/sshd/log 

COPY --chown=root:root files/boot.sh /sbin/boot.sh
COPY --chown=root:root files/sshd.runit /etc/sv/sshd/run
COPY --chown=root:root files/sshd-log.runit /etc/sv/sshd/log/run

RUN sed -i -e "s/USERNAME/$username/g" /sbin/boot.sh \
&& chmod 755 /sbin/boot.sh /etc/sv/sshd/run /etc/sv/sshd/log/run \
&& ln -s /etc/sv/sshd /etc/service/sshd

EXPOSE 22

CMD ["/sbin/boot.sh", "${ANSIBLE_CONTROLLER='false'}"]
