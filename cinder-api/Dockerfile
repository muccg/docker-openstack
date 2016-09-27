FROM muccg/openstackbase:liberty
MAINTAINER https://github.com/muccg/

RUN apt-get -qqy update && apt-get install -y --no-install-recommends \
  cinder-api \
  mysql-client \
  python-memcache \
  python-pymysql \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run with supervisord
COPY supervisord/openstack.conf /etc/supervisor/conf.d/openstack.conf

EXPOSE 8776

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
