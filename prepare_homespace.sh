#!/bin/bash

#####
# This script sets up the basic user Jupyter home directory for use on Pangeo.
# Wholly duplicated from https://github.com/pangeo-data/helm-chart/blob/8eb9c1a78c9b27fd75c540b389d3bb2ca056e070/docker-images/notebook/prepare.sh.
#####


set -x


#########################
# Add example notebooks #
#########################

echo "Getting example notebooks..."
if [ -z "$EXAMPLES_GIT_URL" ]; then
    export EXAMPLES_GIT_URL=https://github.com/pangeo-data/pangeo-example-notebooks
fi
rmdir examples &> /dev/null # deletes directory if empty, in favour of fresh clone
if [ ! -d "examples" ]; then
  git clone $EXAMPLES_GIT_URL examples
fi
cd examples
chmod -R 700 *.ipynb
git remote set-url origin $EXAMPLES_GIT_URL
git fetch origin
git reset --hard origin/master
git merge --strategy-option=theirs origin/master
if [ ! -f DONT_SAVE_ANYTHING_HERE.md ]; then
  echo "Files in this directory should be treated as read-only"  > DONT_SAVE_ANYTHING_HERE.md
fi
chmod -R 400 *.ipynb
cd ..
echo "Done"


#####################################
# Update .ssh directory permissions #
#####################################

chmod -R 400 .ssh/id_rsa &> /dev/null


######################
# Run extra commands #
######################
$@
