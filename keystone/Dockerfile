FROM muccg/openstackbase
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN apt-get -qqy update
RUN DEBIAN_FRONTEND=noninteractive apt-get install keystone supervisor -y

# Run keystone with supervisord
COPY supervisord/supervisord-keystone.conf /etc/supervisor/conf.d/supervisord-keystone.conf

VOLUME /etc/keystone

EXPOSE 35357
EXPOSE 5000

CMD ["/usr/bin/supervisord", "-n"]
