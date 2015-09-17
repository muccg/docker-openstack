#!/bin/sh
#
# Script to build images
#

# break on error
set -e

DATE=`date +%Y.%m.%d`
BRANCH='kilo'

# ensure we build base first
docker build -t muccg/openstackbase:${BRANCH} openstackbase

# build sub dirs
for dir in */
do
    dir=${dir%*/}
    echo "################################################################### ${dir##*/}"
    docker build -t muccg/${dir}:${BRANCH}.${DATE} ${dir}
    docker build -t muccg/${dir}:${BRANCH} ${dir}
done

# publish sub dirs
for dir in */
do
    dir=${dir%*/}
    echo "################################################################### ${dir##*/}"
    docker push muccg/${dir}:${BRANCH}.${DATE}
    docker push muccg/${dir}:${BRANCH}
done
