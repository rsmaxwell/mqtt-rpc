#!/bin/sh

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}



echo "whoami"
whoami

echo "listing of /home/gradle"
ls -al /home/gradle

echo "PROJECT_DIR: ${PROJECT_DIR}"

echo "tree of the PROJECT_DIR"
tree -pug ${PROJECT_DIR}



${PROJECT_DIR}/gradlew publish \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
