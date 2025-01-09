#!/bin/bash

# Original license of this script and the bash bible :

# The MIT License (MIT)
# Copyright (c) 2018 Dylan Araps
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# this script has been modified, the original is https://github.com/dylanaraps/pure-bash-bible/blob/master/build.sh


main() {
    if [[ ! -f README.md ]]; then
        wget https://raw.githubusercontent.com/dylanaraps/pure-bash-bible/refs/heads/master/README.md
    fi

    # Split the README.md into chapters based on markers.
    while IFS=$'\n' read -r line; do
        [[ "$chap" ]] && chapter[$i]+="$line"$'\n'
        [[ "$line" == "<!-- CHAPTER START -->" ]] && chap=1
        [[ "$line" == "<!-- CHAPTER END -->" ]]   && { chap=; ((i++)); }
    done < README.md

    local chapter_title

    # Write the chapters to separate files.
    for i in "${!chapter[@]}"; do
        : "${chapter[$i]/$'\n'*}"; : "${_/\# }"; : "${_,,}"
        
        # the chapter's title is not always on the first line
        chapter_title=$(echo "${chapter[$i]}" | head -2 | grep -e "^# " | cut -d " " -f2- | tr " " "-")
        echo "mkdir ${chapter_title,,}/"
        echo "touch"

        # printf '%s\n' "${chapter[$i]}" > "manuscript/chapter${i}.txt"
        # printf '%s\n' "chapter${i}.txt" >> "manuscript/Book.txt"
    done
}

main