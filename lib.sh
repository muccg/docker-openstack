#!/bin/sh
#
# common definitons shared between projects
#
set -a

TOPDIR=$(cd `dirname $0`; pwd)
DATE=`date +%Y.%m.%d`

: ${DOCKER_BUILD_PROXY:="--build-arg http_proxy"}
: ${DOCKER_USE_HUB:="0"}
: ${SET_HTTP_PROXY:="1"}
: ${SET_PIP_PROXY:="1"}
: ${DOCKER_NO_CACHE:="0"}
: ${DOCKER_PULL:="1"}

# Do not set these, they are vars used below
DOCKER_ROUTE=''
DOCKER_BUILD_OPTS=''
DOCKER_RUN_OPTS='-e PIP_INDEX_URL -e PIP_TRUSTED_HOST'
DOCKER_COMPOSE_BUILD_OPTS=''


info () {
  printf "\r  [ \033[00;34mINFO\033[0m ] $1\n"
}


success () {
  printf "\r\033[2K  [ \033[00;32m OK \033[0m ] $1\n"
}


fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit 1
}


docker_options() {
    DOCKER_ROUTE=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
    success "Docker ip ${DOCKER_ROUTE}"

    _http_proxy
    _pip_proxy

    if [ ${DOCKER_PULL} = "1" ]; then
         DOCKER_BUILD_PULL="--pull=true"
         DOCKER_COMPOSE_BUILD_PULL="--pull"
    else
         DOCKER_BUILD_PULL="--pull=false"
         DOCKER_COMPOSE_BUILD_PULL=""
    fi

    if [ ${DOCKER_NO_CACHE} = "1" ]; then
         DOCKER_BUILD_NOCACHE="--no-cache=true"
         DOCKER_COMPOSE_BUILD_NOCACHE="--no-cache"
    else
         DOCKER_BUILD_NOCACHE="--no-cache=false"
         DOCKER_COMPOSE_BUILD_NOCACHE=""
    fi

    DOCKER_BUILD_OPTS="${DOCKER_BUILD_NOCACHE} ${DOCKER_BUILD_PROXY} ${DOCKER_BUILD_PULL} ${DOCKER_BUILD_PIP_PROXY}"

    # compose does not expose all docker functionality, so we can't use compose to build in all cases
    DOCKER_COMPOSE_BUILD_OPTS="${DOCKER_COMPOSE_BUILD_OPTS} ${DOCKER_COMPOSE_BUILD_NOCACHE} ${DOCKER_COMPOSE_BUILD_PULL}"
}


_http_proxy() {
    info 'http proxy'

    if [ ${SET_HTTP_PROXY} = "1" ]; then
        if [ -z ${HTTP_PROXY_HOST+x} ]; then
            HTTP_PROXY_HOST=${DOCKER_ROUTE}
        fi
        http_proxy="http://${HTTP_PROXY_HOST}:3128"
        HTTP_PROXY="http://${HTTP_PROXY_HOST}:3128"
        NO_PROXY=${HTTP_PROXY_HOST}
        no_proxy=${HTTP_PROXY_HOST}
        success "Proxy $http_proxy"
    else
        info 'Not setting http_proxy'
    fi

    export HTTP_PROXY http_proxy NO_PROXY no_proxy

    success "HTTP proxy ${HTTP_PROXY}"
}


_pip_proxy() {
    info 'pip proxy'

    # pip defaults
    PIP_INDEX_URL='https://pypi.python.org/simple'
    PIP_TRUSTED_HOST='127.0.0.1'

    if [ ${SET_PIP_PROXY} = "1" ]; then
        if [ -z ${PIP_PROXY_HOST+x} ]; then
            PIP_PROXY_HOST=${DOCKER_ROUTE}
        fi
        # use a local devpi install
        PIP_INDEX_URL="http://${PIP_PROXY_HOST}:3141/root/pypi/+simple/"
        PIP_TRUSTED_HOST="${PIP_PROXY_HOST}"
    fi

    export PIP_INDEX_URL PIP_TRUSTED_HOST

    success "Pip index url ${PIP_INDEX_URL}"
}


_ci_docker_login() {
    info 'Docker login'
    docker login -u ${DOCKER_USERNAME} --password="${DOCKER_PASSWORD}"
    success "Docker login"
}
