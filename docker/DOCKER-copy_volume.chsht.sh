#!/bin/bash

# KEYWORDS: volume copy duplicate backup

# name of the volumes
original=
duplicate=

# won't overwrite if already exist
docker volume create --name "${duplicate}"

# use busybox as minimal distro to make the copy
# for less verbose output, use "cp -a . /to"
docker container run --rm -it -v "${original}:/from" -v "${duplicate}:/to"\
 busybox ash -c "cd /from; cp -av . /to"

# to use this system as a "backup" for volumes, don't forget to stop the 
# container(s) using the volume to be replaced.
