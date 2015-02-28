FROM muccg/openstackbase
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN apt-get -qqy update && apt-get install -y --no-install-recommends \
  python-ceilometerclient \
  python-cinderclient \
  python-glanceclient \
  python-heatclient \
  python-keystoneclient \
  python-neutronclient \
  python-novaclient \
  python-swiftclient \
  python-troveclient \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/sh"]
