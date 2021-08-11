FROM debian:latest
ARG username
ARG password
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install \
   ssh \
   sudo \
&& apt-get autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& chmod 4511 /usr/bin/sudo \
&& useradd -m -G sudo -s /bin/bash $username \
&& echo "$password\n$password\n" | passwd $username \
&& service ssh start

COPY --chown=root:root files/boot.sh /sbin/boot.sh

RUN chmod 755 /sbin/boot.sh

EXPOSE 22

CMD ["/sbin/boot.sh"]
