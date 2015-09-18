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

# Don't really want this here. Plus it prompts for username, no switch to tell it to blow up
docker login -u ccgbuildbot

# publish sub dirs
for dir in */
do
    dir=${dir%*/}
    echo "################################################################### ${dir##*/}"
    docker push muccg/${dir}:${BRANCH}.${DATE}
    docker push muccg/${dir}:${BRANCH}
done
