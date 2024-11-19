#!/bin/bash

# KEYWORDS: dict dictionary iterate print array associative index

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
