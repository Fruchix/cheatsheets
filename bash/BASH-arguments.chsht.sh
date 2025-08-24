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

# KEYWORDS: read arguments stdout parse positional script

# REFERENCES:
# https://stackoverflow.com/a/14063511
# https://stackoverflow.com/a/14203146

POSITIONAL_ARGS=()
POSITIONAL_ARGS_FOR_OPTION_S=()

while [[ $# -gt 0 ]]; do
    opt="$1";
    shift;
    # we could remove double quotes
    case "$opt" in
        "--" ) break 2;;
        "-" ) break 2;;
        "-r"|"--requires_value" )
            # current $1 is the value
            VALUE="$1"
            shift
            ;;
        "--requires_value="* )
            # current $opt contains the value
            VALUE="${opt#*=}"
            ;;
        "-g"|"--gnu-value="* )
            local value
            if [[ ${#opt} -eq 2 ]]; then
                value="$1"
                shift
            else
                value="${opt#*=}"
            fi
            VALUE=$value
            ;;
        "-d"|"--doesnt_require_value" )
            MODE=1
            ;;
        "-s"|"--set-of-positional-values" )
            # read all positional arguments after the named argument itself, 
            # until the next named argument argument
            while (( "$#" >= 1 )) && ! [[ $1 = -* ]]; do
                POSITIONAL_ARGS_FOR_OPTION_S+=( "$1" )
                shift
            done
            ;;
        -*|--*)
            echo >&2 "Invalid option: $opt"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$opt") # save positional arg that do not depend on a specific named arg
            ;;
   esac
done
