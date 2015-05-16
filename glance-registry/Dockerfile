FROM muccg/openstackbase:icehouse
MAINTAINER https://github.com/muccg/

RUN apt-get -qqy update && apt-get install -y --no-install-recommends \
  glance-registry \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run with supervisord
COPY supervisord/openstack.conf /etc/supervisor/conf.d/openstack.conf

EXPOSE 9191

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
