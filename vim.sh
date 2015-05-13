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
echo $FILE
echo $BASEDIR

docker run -i -t --rm -v /Users/Ivo:/Users/Ivo iverberk/vim-go $BASEDIR $FILE

exit 0
