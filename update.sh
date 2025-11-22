#!/usr/bin/env bash

set -e -x -u -o pipefail

cd ~/a54

while sleep 1
do
    date
    ifconfig | grep inet | sed -E s' \s+\S+\s+(\S+).* \1 ' | sort | uniq | grep -v 127.0.0.1 > ip.txt
    if [ -n "$(git status --porcelain)" ]
    then
        ~/c/gitpush
    fi
    sleep 300
done
