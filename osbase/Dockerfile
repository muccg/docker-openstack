FROM ubuntu:14.04
MAINTAINER ccg <ccgdevops@googlegroups.com>

ENV BASE_VERSION 2015-02-27
ENV OPENSTACK_VERSION icehouse

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  language-pack-en \
  && locale-gen en_US \
  && apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  build-essential \
  ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN env --unset=DEBIAN_FRONTEND

CMD ['/bin/sh']
