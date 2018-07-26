#!/bin/bash

set -e

# Login
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

# Add new tags
docker tag informaticslab/pangeo-notebook:$TRAVIS_COMMIT informaticslab/pangeo-notebook:latest

# Push to Docker Hub
docker push informaticslab/pangeo-notebook:$TRAVIS_COMMIT
docker push informaticslab/pangeo-notebook:latest
