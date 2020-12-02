FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get -y --no-install-recommends install openssh-client openssh-server \
sudo \
&& /etc/init.d/ssh start

RUN useradd -m -G sudo user \
&& echo 'password\npassword\n' | passwd user

VOLUME [ "/root", "/usr", "/home" ]

EXPOSE 22

CMD ["sh", "-c", "/etc/init.d/ssh start; cd; exec bash -i"]
