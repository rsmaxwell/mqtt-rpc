#!/bin/bash

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}

# export GRADLE_USER_HOME=/home/gradle/.gradle

echo "whoami: $(whoami)"
echo "GRADLE_USER_HOME=$GRADLE_USER_HOME"
echo "HOME=$HOME"
env | sort | grep -E 'GRADLE|HOME'
ls -al "$GRADLE_USER_HOME" || true
ls -al "$GRADLE_USER_HOME/gradle.properties" || true

${PROJECT_DIR}/gradlew publish --info --stacktrace \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
