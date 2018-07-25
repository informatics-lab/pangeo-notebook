#!/bin/bash

# Login
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Add new tags
docker tag informatics-lab/pangeo-notebook:$TRAVIS_COMMIT informatics-lab/pangeo-notebook:latest

# Push to Docker Hub
docker push informatics-lab/pangeo-notebook:$TRAVIS_COMMIT
docker push informatics-lab/pangeo-notebook:latest
