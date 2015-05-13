#!/bin/bash

FILE=$PWD/$1

if [[ $1 == /* ]]; then
    FILE=$1
fi

# Calculate base path
BASEDIR=$(dirname $FILE)
if [ -d $FILE ]; then
    BASEDIR=$FILE
fi

docker run -i -t --rm --hostname dev -v /Users/Ivo:/Users/Ivo iverberk/vim-go $BASEDIR $FILE

exit 0
