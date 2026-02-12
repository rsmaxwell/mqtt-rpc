#!/bin/sh

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}


# Force Gradle to use the PVC-backed directory for ~/.gradle
export GRADLE_USER_HOME=/home/gradle
# (optional but often helps tools that rely on HOME)
export HOME=/home/gradle


${PROJECT_DIR}/gradlew publish \
    -PrepositoryName=${REPOSITORY} \
    -PprojectVersion=${VERSION}
