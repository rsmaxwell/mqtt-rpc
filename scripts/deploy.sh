#!/bin/bash

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}




set -x
ls -al /home/gradle
echo "PROJECT_DIR: ${PROJECT_DIR}"
tree -pug ${PROJECT_DIR}
whoami
id jenkins
id ubuntu
id gradle

find /home -maxdepth 2 -name gradle.properties -type f

set +x




${PROJECT_DIR}/gradlew publish \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
