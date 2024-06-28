#!/bin/sh

set -x

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}


${PROJECT_DIR}/gradlew publish --no-daemon --info --warning-mode all \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
