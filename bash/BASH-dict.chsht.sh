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

# KEYWORDS: dict dictionary iterate print array associative index key value

# array MUST be declare as associative using declare -A
declare -A my_array

my_array=([a]=aa [b]=bb)
my_array+=([c]=cc)
my_array[d]="dd"

function iterate_associative_array() {
    local -n arr_name=$1

    for key in "${!arr_name[@]}"; do
        echo "$key=${arr_name[$key]}"
    done
}

iterate_associative_array my_array
