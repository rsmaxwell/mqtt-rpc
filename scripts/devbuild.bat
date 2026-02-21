

SCRIPT_DIR=C:\Users\Richard\git\github.com\rsmaxwell\mqtt-rpc\scripts
PROJECT_DIR=C:\Users\Richard\git\github.com\rsmaxwell\mqtt-rpc
BUILD_DIR=C:\Users\Richard\git\github.com\rsmaxwell\mqtt-rpc\build

call ${BUILD_DIR}/buildinfo


cd ${PROJECT_DIR}

echo "${BUILD_DIR}/buildinfo:"
cat ${BUILD_DIR}/buildinfo

echo "REPOSITORY: $REPOSITORY"
echo "VERSION: $VERSION"

./gradlew publish --no-daemon --info \
    -PrepositoryName="${REPOSITORY}" \
    -PprojectVersion="${VERSION}"
