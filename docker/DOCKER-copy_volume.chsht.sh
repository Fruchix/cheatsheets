#!/usr/bin/env bash

############################################################################
# Copyright 2025 Fruchix                                                   #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#     http://www.apache.org/licenses/LICENSE-2.0                           #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #
############################################################################

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
