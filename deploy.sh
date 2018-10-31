#!/bin/bash

set -e

# Login to docker hub
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

# Lockin to AWS ECR (Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY env vars to be set)
$(aws ecr get-login --no-include-email --region eu-west-2)

for REPOSITORY in 'informaticslab/pangeo-notebook' '536099501702.dkr.ecr.eu-west-2.amazonaws.com/pangeo-notebook'; do

    # If this isn't a tagged commit push the hash and update dev
    # If this is a tagged commit push that tag and update latest
    if [ "$TRAVIS_TAG" = "" ]; then
        # Push the commit tag
        docker tag pangeo-notebook:${TRAVIS_COMMIT:0:8} ${REPOSITORY}:${TRAVIS_COMMIT:0:8}
        docker push ${REPOSITORY}:${TRAVIS_COMMIT:0:8}

        # Replace the dev tag with the commit tag
        docker tag pangeo-notebook:${TRAVIS_COMMIT:0:8} ${REPOSITORY}:dev
        docker push ${REPOSITORY}:dev
    else
        # Push the release tag
        docker tag pangeo-notebook:${TRAVIS_COMMIT:0:8} ${REPOSITORY}:$TRAVIS_TAG
        docker push ${REPOSITORY}:$TRAVIS_TAG

        # Replace the latest tag with the release tag
        docker tag pangeo-notebook:${TRAVIS_COMMIT:0:8} ${REPOSITORY}:latest
        docker push ${REPOSITORY}:latest
    fi

done
