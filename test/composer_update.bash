#!/bin/bash -e

TEST_ROOT=test
SOURCE_ROOT=..

if [ "$(basename $(pwd))" != "$TEST_ROOT" ]; then
    echo "test run in wrong directory"
    exit 1
fi

TEST_CONTAINER_NAME=test-wn-composer-update
TEST_CONTAINER_TYPE=$SOURCE_ROOT/php8.0/apache
TEST_CONTAINER_DOCKERFILE=Dockerfile
# TEST_CONTAINER_DOCKERFILE=Dockerfile.develop

echo "build test"
docker build -t $TEST_CONTAINER_NAME $TEST_CONTAINER_TYPE -f $TEST_CONTAINER_TYPE/$TEST_CONTAINER_DOCKERFILE || exit 1

echo "run test container"
docker run \
    -it \
    --rm \
    -p 8888:80 \
    -e COMPOSER_UPDATE=true \
    $TEST_CONTAINER_NAME \
    bash -c "echo 'container test run complete'; exit 0" || exit 1

echo "test done"

exit 0
