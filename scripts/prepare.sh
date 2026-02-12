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
SCRIPT_DIR=$(cd "$BASEDIR" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")
BUILD_DIR="${PROJECT_DIR}/build"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

cat > buildinfo <<EOL
VERSION="${VERSION}"
REPOSITORY="${REPOSITORY}"
EOL

tree "${PROJECT_DIR}"

# ---- Common metadata shared by all modules (matches your module scripts) ----
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
GIT_COMMIT="${GIT_COMMIT:-(none)}"
GIT_BRANCH="${GIT_BRANCH:-(none)}"
GIT_URL="${GIT_URL:-(none)}"

# Tags that templates may reference
tags='$FAMILY,$ARCHITECTURE,$PROJECT,$REPOSITORY,$REPOSITORYID,$VERSION,$BUILD_ID,$TIMESTAMP,$GIT_COMMIT,$GIT_BRANCH,$GIT_URL'

# Export common vars once (module-specific ones set inside the loop)
export REPOSITORY REPOSITORYID BUILD_ID VERSION TIMESTAMP GIT_COMMIT GIT_BRANCH GIT_URL FAMILY ARCHITECTURE

# Exact module names from your repo
modules=(
  mqtt-rpc-common
  mqtt-rpc-request
  mqtt-rpc-response
)

for module in "${modules[@]}"; do
  MODULE_DIR="${PROJECT_DIR}/${module}"
  SOURCE_DIR="${MODULE_DIR}/src"
  TEMPLATES_DIR="${MODULE_DIR}/templates"
  MODULE_BUILD_DIR="${MODULE_DIR}/app/build"   # matches your module prepare.sh

  PROJECT="${module}"
  GROUPID="com.rsmaxwell.mqtt.rpc"
  ARTIFACTID="${PROJECT}"
  PACKAGING="zip"
  ZIPFILE="${ARTIFACTID}"

  export PROJECT GROUPID ARTIFACTID PACKAGING ZIPFILE

  echo "=== Preparing module: ${module} ==="

  if [ -d "${TEMPLATES_DIR}" ]; then
    cd "${TEMPLATES_DIR}"

    find . -type f | while read filename; do
      echo "Writing ${filename}"
      file="${SOURCE_DIR}/${filename}"
      dir="$(dirname "$file")"
      mkdir -p "$dir"
      envsubst "$tags" < "$filename" > "$file"
    done

    tree "${SOURCE_DIR}"
  else
    echo "WARNING: no templates dir for ${module}: ${TEMPLATES_DIR}" >&2
  fi

  mkdir -p "${MODULE_BUILD_DIR}"
  cd "${MODULE_BUILD_DIR}"

  cat > buildinfo <<EOL
BUILD_ID="${BUILD_ID}"
VERSION="${VERSION}"
REPOSITORY="${REPOSITORY}"
REPOSITORYID="${REPOSITORYID}"
REPOSITORY_URL="${REPOSITORY_URL}"
FAMILY="${FAMILY}"
ARCHITECTURE="${ARCHITECTURE}"
PROJECT="${PROJECT}"
GROUPID="${GROUPID}"
ARTIFACTID="${ARTIFACTID}"
PACKAGING="${PACKAGING}"
ZIPFILE="${ZIPFILE}"
TIMESTAMP="${TIMESTAMP}"
GIT_COMMIT="${GIT_COMMIT}"
GIT_BRANCH="${GIT_BRANCH}"
GIT_URL="${GIT_URL}"
EOL

  pwd
  ls -al
  cat buildinfo
done



echo "whoami"
whoami

echo "listing of HOME"
ls -al "$HOME"

echo "tree of the HOME"
tree -pug ${HOME}


