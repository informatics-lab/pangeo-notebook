#!/usr/bin/env bash

rm -rf ~/examples
git clone https://github.com/informatics-lab/example-notebooks.git ~/examples

exec "$@"
