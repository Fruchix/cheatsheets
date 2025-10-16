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

# KEYWORDS: read input ask user question yes no answer

# defaut choice is negative
while true; do
    echo -n "QUESTION? [y/N] "
    read -r
    case $REPLY in
        [Yy]|[Yy][Ee][Ss])
            ;;
        [Nn]|[Nn][Oo]|"")
            ;;
        *) echo "Not a valid answer.";;
    esac
done

# defaut choice is positive
while true; do
    echo -n "QUESTION? [Y/n] "
    read -r
    case $REPLY in
        [Yy]|[Yy][Ee][Ss]|"")
            ;;
        [Nn]|[Nn][Oo])
            ;;
        *) echo "Not a valid answer.";;
    esac
done