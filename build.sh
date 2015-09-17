#!/bin/sh
#
# Script to build images
#

# break on error
set -e

DATE=`date +%Y.%m.%d`
BRANCH='kilo'

# ensure we build base first, dir name breaks convention
docker build -t muccg/openstackbase:${BRANCH} base

# build sub dirs
for dir in */
do
    dir=${dir%*/}
    echo ${dir##*/}
    docker build -t muccg/${dir}:${BRANCH}.${DATE} ${dir}
done
