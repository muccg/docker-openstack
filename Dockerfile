FROM ubuntu:14.04
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN apt-get -qqy update
RUN DEBIAN_FRONTEND=noninteractive apt-get install keystone supervisor -y

# Run keystone with supervisord
ADD supervisord/supervisord-keystone.conf /etc/supervisor/conf.d/supervisord-keystone.conf

# Restart supervisord
RUN service supervisor start

# Change keystone.conf admin key
RUN sed 's/#admin_token=ADMIN/admin_token=7a04a385b907caca141f/g' -i /etc/keystone/keystone.conf

EXPOSE 35357
EXPOSE 5000

CMD ["/usr/bin/supervisord", "-n"]
