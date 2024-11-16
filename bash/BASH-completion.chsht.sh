#!/bin/bash

# KEYWORDS: completion script

# REFERENCES:
# https://askubuntu.com/questions/68175/how-to-create-script-with-auto-complete
# https://web.archive.org/web/20190328055722/https://debian-administration.org/article/316/An_introduction_to_bash_completion_part_1
# https://web.archive.org/web/20140405211529/http://www.debian-administration.org/article/317/An_introduction_to_bash_completion_part_2
#
# https://unix.stackexchange.com/questions/273948/bash-completion-for-user-without-access-to-etc
# https://unix.stackexchange.com/questions/4219/how-do-i-get-bash-completion-for-command-aliases
# 
# https://stackoverflow.com/questions/62979947/how-to-autocomplete-files-under-specific-directory
#
# man bash-builtins: search "compgen" and "complete"

# stub function that only prints its parameters
function mytool()
{
    echo "$@"
}

# Example of completion for a tool called "mytool", with usage:
#   mytool select <dir|file> [dir|file] [dir|file] ...
#   mytool [-abc]
_mytool_completion()
{
    # all variable should be local
    local cur prev opts first_cw second_cw arr file
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # e.g. for default options
    opts="-a -b -c select"

    # how to get a comp word at a specific position, 
    # could be useful when we need completion on a list of directories, files, etc.
    # e.g. mytool select <file1> [file2] [file3] ...: the completion needs to refer to the first comp word
    first_cw="${COMP_WORDS[COMP_CWORD-COMP_CWORD]}"
    # or:
    # first_cw="$1"
    second_cw="${COMP_WORDS[COMP_CWORD-COMP_CWORD+1]}"

    # e.g. for "select":
    # completion for specific alias and for "select" option of mytool
    if [[ "${first_cw}" == "mts" \
        || "${second_cw}" == "select" \
    ]]; then
        arr=( $( compgen -f -- "$cur" ) )
        COMPREPLY=()
        # add the file to the COMPREPLY array,
        # and add a trailing "/" if its a dir, to be able to have completion again
        for file in "${arr[@]}"; do
            if [[ -d $file ]]; then
                file="$file/"
            fi
            COMPREPLY+=("$file")
        done
        return 0
    fi

    # default: suggest possible options
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

# example of alias for mytool, that will get completion too
alias mts="mytool select"

# activate completion for a program/function
complete -F _mytool_completion -o nospace mytool
complete -F _mytool_completion -o nospace mts

# nospace option: do not add a space after selecting completion
