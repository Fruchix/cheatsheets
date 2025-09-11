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

# KEYWORDS: script directory current locate location

# bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# zsh
script_dir=$( cd -- "$( dirname -- "${(%):-%N}" )" && pwd )


# in a script that can be sourced or either executed by zsh and bash
if [ -n "${BASH_SOURCE:-}" ]; then
  # Bash
  script_path="${BASH_SOURCE[0]}"
elif [ -n "${ZSH_VERSION:-}" ]; then
  # zsh
  script_path="${(%):-%N}"
fi
script_dir=$( cd -- "$( dirname -- "$script_path" )" && pwd )

