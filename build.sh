#!/bin/sh
#
# Script to build images
#

: ${OPENSTACK_VERSION:='liberty'}
. ./lib.sh

set -e



build_image() {
    info "################################################################### ${IMAGE}"

    set -x
    docker pull muccg/${IMAGE}:${OPENSTACK_VERSION} || true
    docker build ${DOCKER_BUILD_OPTS} -t muccg/${IMAGE}:${OPENSTACK_VERSION} ${IMAGE}
    docker build ${DOCKER_BUILD_OPTS} -t muccg/${IMAGE}:${OPENSTACK_VERSION}-${DATE} ${IMAGE}
    set +x

    # ensure we build base first, everything extends from this
    success "$(docker images | grep "muccg/${IMAGE}" | grep ${OPENSTACK_VERSION} | sed 's/  */ /g')"

    # push
    if [ ${DOCKER_USE_HUB} = "1" ]; then
        _ci_docker_login
        docker push muccg/${IMAGE}:${OPENSTACK_VERSION}-${DATE}
        docker push muccg/${IMAGE}:${OPENSTACK_VERSION}
    fi
}

docker_options
info "${DOCKER_BUILD_OPTS}"

# build the base image first
IMAGE="openstackbase"
build_image

# stop build trying to get a 'newer' base image
DOCKER_PULL=0
docker_options
info "${DOCKER_BUILD_OPTS}"

# build sub dirs
for dir in */
do
    dir=${dir%*/}
    IMAGE="${dir}"
    build_image
done
