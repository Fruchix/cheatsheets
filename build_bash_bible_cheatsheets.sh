#!/bin/bash

# Original license of this script and the bash bible :

# The MIT License (MIT)
# Copyright (c) 2018 Dylan Araps
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# this script has been modified, the original is https://github.com/dylanaraps/pure-bash-bible/blob/master/build.sh

word_separator="_"
bash_bible_dir="bash-bible"

main() {
    local chapter_title char output line i j

    rm -r "${bash_bible_dir}"
    mkdir -p "${bash_bible_dir}"

    if [[ ! -f README-bash-bible.md ]]; then
        wget -O "README-bash-bible.md" https://raw.githubusercontent.com/dylanaraps/pure-bash-bible/refs/heads/master/README.md
    fi

    # Split the README.md into chapters based on markers.
    while IFS=$'\n' read -r line; do
        [[ "$chap" ]] && chapter[$i]+="$line"$'\n'
        [[ "$line" == "<!-- CHAPTER START -->" ]] && chap=1
        [[ "$line" == "<!-- CHAPTER END -->" ]]   && { chap=; ((i++)); }
    done < README-bash-bible.md

    rm README-bash-bible.md

    # Write the chapters to separate files.
    for i in "${!chapter[@]}"; do
        : "${chapter[$i]/$'\n'*}"; : "${_/\# }"; : "${_,,}"
        
        # the chapter's title is not always on the first line
        chapter_title=$(echo "${chapter[$i]}" | head -2 | grep -e "^# " | cut -d " " -f2- | tr " " "${word_separator}")
        chapter_title="${chapter_title,,}"

        mkdir "${bash_bible_dir}/${chapter_title}" && echo "Created folder ${bash_bible_dir}/${chapter_title,,}/"

        # the name of the cheatsheet
        output=""

        # parse the chapter in different cheatsheets : each title of level "##" will result in its own cheatsheet
        while IFS=$'\n' read -r line; do
            # do not add the title to the cheatsheet
            if [[ ${line,,} == *"${chapter_title}"* ]]; then
                continue
            fi

            # get the name of the cheatsheet from the title
            if [[ $line =~ ^"## " ]]; then
                # if pandoc is installed, convert the last cheatsheet (before this new title) to text (from markdown)
                if [[ $(command -v pandoc) && -n ${output} ]]; then
                    echo >> "${bash_bible_dir}/${chapter_title}/${output}.tmp"
                    pandoc -f markdown -t plain "${bash_bible_dir}/${chapter_title}/${output}.tmp" -o "${bash_bible_dir}/${chapter_title}/BASH-${output}.chsht.sh" && {
                        echo "Added ${bash_bible_dir}/${chapter_title}/BASH-${output}.chsht.sh"
                    }
                    rm "${bash_bible_dir}/${chapter_title}/${output}.tmp" && echo "Removed ${bash_bible_dir}/${chapter_title}/${output}.tmp"
                fi

                output=""
                char=""
                # build the name of the cheatsheet from the title
                for (( j=0; j<${#line}; j++ )); do
                    line="${line#"## "}"
                    line="${line,,}"

                    char="${line:$j:1}"

                    # remove all non ascii characters and replace spaces by a defined separator
                    if [[ "$char" =~ [a-z0-9] ]]; then
                        output="$output$char"
                    elif [[ "$char" == " " ]]; then
                        output="${output}${word_separator}"
                    fi
                done

                echo "#!/usr/bin/env bash" > "${bash_bible_dir}/${chapter_title}/${output}.tmp" && echo "Added ${bash_bible_dir}/${chapter_title}/${output}.tmp"
                continue
            fi

            if [[ -n ${output} ]]; then
                echo "${line}" >> "${bash_bible_dir}/${chapter_title}/${output}.tmp"
            fi
        done <<< "${chapter[$i]}"

        # if pandoc is installed, convert the last cheatsheet (before the end of file) to text (from markdown)
        if [[ $(command -v pandoc) && -n ${output} ]]; then
            pandoc -f markdown -t plain "${bash_bible_dir}/${chapter_title}/${output}.tmp" -o "${bash_bible_dir}/${chapter_title}/BASH-${output}.chsht.sh" && {
                echo "Added ${bash_bible_dir}/${chapter_title}/BASH-${output}.chsht.sh"
            }
            rm "${bash_bible_dir}/${chapter_title}/${output}.tmp" && echo "Removed ${bash_bible_dir}/${chapter_title}/${output}.tmp"
        fi
    done
}

main
