#!/bin/bash

set -e
set -x 

# Check required env variables are set
case "$FAMILY" in
  alpine|linux) ;;
  *)
    echo "ERROR: invalid FAMILY='$FAMILY' (allowed: alpine|linux)" >&2
    exit 2
    ;;
esac

case "$ARCHITECTURE" in
  amd64|arm64) ;;
  *)
    echo "ERROR: invalid ARCHITECTURE='$ARCHITECTURE' (allowed: amd64|arm64)" >&2
    exit 2
    ;;
esac



if [ -z "${BUILD_ID}" ]; then
    BUILD_ID="(none)"
    VERSION="0.0.1-SNAPSHOT"
    REPOSITORY=snapshots
    REPOSITORYID=snapshots
else
    VERSION="0.0.1.$((${BUILD_ID}))"
    REPOSITORY=releases
    REPOSITORYID=releases
fi


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build


mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cat > buildinfo <<EOL
VERSION="${VERSION}"
REPOSITORY="${REPOSITORY}"
EOL


${PROJECT_DIR}/mqtt-rpc-common/scripts/prepare.sh
${PROJECT_DIR}/mqtt-rpc-request/scripts/prepare.sh
${PROJECT_DIR}/mqtt-rpc-response/scripts/prepare.sh
