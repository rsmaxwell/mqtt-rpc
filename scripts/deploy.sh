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
find /home -maxdepth 4 -name gradle.properties -type f
tree -pug -L 3 /home/gradle
cat /home/gradle/.gradle/gradle.properties
tree -pug -L 3 /home 
set +x


export GRADLE_USER_HOME=/home/gradle/.gradle

${PROJECT_DIR}/gradlew publish \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
