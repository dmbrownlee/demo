FROM alpine:latest
ARG username
ARG password

RUN apk add --no-cache sudo
RUN apk add --no-cache openssh-server \
&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN apk add --no-cache bash \
&& addgroup $username \
&& adduser -h /home/$username -G $username -s /bin/bash -D $username \
&& echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible \
&& echo -e "$password\n$password\n" | passwd $username

COPY --chown=root:root files/boot.sh /sbin/boot.sh

RUN chmod 744 /sbin/boot.sh

EXPOSE 22

CMD ["/sbin/boot.sh", "${ANSIBLE_CONTROLLER='false'}"]
