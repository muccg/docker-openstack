FROM muccg/openstackbase:icehouse
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN apt-get -qqy update && apt-get install -y --no-install-recommends \
  keystone \
  python-keystoneclient \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run keystone with supervisord
COPY supervisord/supervisord-keystone.conf /etc/supervisor/conf.d/supervisord-keystone.conf

VOLUME /etc/keystone

EXPOSE 35357 5000

CMD ["/usr/bin/supervisord", "-n"]
