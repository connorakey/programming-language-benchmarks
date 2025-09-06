#!/bin/bash

fibonacci() {
    local n=$1
    local a=0
    local b=1
    
    for ((i=0; i<n; i++)); do
        local temp=$a
        a=$b
        b=$((b + temp))
    done
    
    echo $a
}

result=$(fibonacci 100000)
echo $result
