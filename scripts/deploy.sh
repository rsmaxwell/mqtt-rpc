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

tree -pug -L 2 /home

ls -al /home
ls -al /home/jenkins
ls -al /home/jenkins/.gradle
ls -al /home/ubuntu
ls -al /home/ubuntu/.gradle
ls -al /home/gradle
ls -al /home/gradle/.gradle

ls -al /home/gradle/.gradle/gradle.properties
cat /home/gradle/.gradle/gradle.properties

tree -pug -L 3 /home 

set +x




${PROJECT_DIR}/gradlew publish \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
