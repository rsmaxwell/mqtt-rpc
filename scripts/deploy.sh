#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}

echo "${BUILD_DIR}/buildinfo:"
cat ${BUILD_DIR}/buildinfo

echo "REPOSITORY: $REPOSITORY"
echo "VERSION: $VERSION"

./gradlew publish --no-daemon --info \
    -PrepositoryName="${REPOSITORY}" \
    -PprojectVersion="${VERSION}"
