# Dockerfile with dependencies
FROM python

RUN mkdir -p /usr/src
WORKDIR /usr/src

COPY requirements /usr/src/requirements/
RUN pip install --no-cache-dir -r requirements/local.txt

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
# postgresql-client - is for db health check script in docker-compose.yml
RUN apt-get install -y --no-install-recommends postgresql-client

# Intall developer tools (not for production)
RUN echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_8.0/ /' >> /etc/apt/sources.list.d/fish.list
RUN wget -qO - http://download.opensuse.org/repositories/shells:fish:release:2/Debian_8.0/Release.key | apt-key add -
RUN apt-get update
RUN apt-get install -y --no-install-recommends fish vim tmux
RUN echo "syntax on" > ~/.vimrc
RUN pip install ipdb

# Setup SSHd
COPY docker_stuff/sshd_config /etc/ssh/
RUN mkdir -p ~/.ssh
RUN chmod 700 ~/.ssh
COPY ssh_keys/my_docker_containers.pub /root/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/*
RUN chown -Rf root:root ~/.ssh
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install openssh-server
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

WORKDIR /usr/src/django_rest_postgres

EXPOSE 8000/tcp 5022
