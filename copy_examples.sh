#!/usr/bin/env bash

rm -rf ~/examples
git clone $EXAMPLES_GIT_URL ~/examples

exec "$@"
