#!/bin/bash

set -e

# Login
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

# If this isn't a tagged commit push the hash and update dev
# If this is a tagged commit push that tag and update latest
if [ "$TRAVIS_TAG" = "" ]; then
    # Push the image to Docker Hub
    docker push informaticslab/pangeo-notebook:${TRAVIS_COMMIT:0:8}

    # Replace the dev tag with the latest commit
    docker tag informaticslab/pangeo-notebook:${TRAVIS_COMMIT:0:8} informaticslab/pangeo-notebook:dev
    docker push informaticslab/pangeo-notebook:dev
else
    docker tag informaticslab/pangeo-notebook:${TRAVIS_COMMIT:0:8} informaticslab/pangeo-notebook:$TRAVIS_TAG
    docker push informaticslab/pangeo-notebook:$TRAVIS_TAG
    docker tag informaticslab/pangeo-notebook:${TRAVIS_COMMIT:0:8} informaticslab/pangeo-notebook:latest
    docker push informaticslab/pangeo-notebook:latest
fi
