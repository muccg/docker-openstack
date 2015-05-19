FROM muccg/openstackbase:icehouse
MAINTAINER https://github.com/muccg/

RUN apt-get -qqy update && apt-get install -y --no-install-recommends \
  openstack-dashboard \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run horizon with supervisord
COPY supervisord/supervisord-horizon.conf /etc/supervisor/conf.d/supervisord-horizon.conf

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
