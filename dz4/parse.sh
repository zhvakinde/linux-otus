#!/bin/bash
LOCK=/var/tmp/lockfile

if [ -f $LOCK ]
then
        echo "File is busy"
        exit 1
else
        touch $LOCK
        trap 'rm -f $LOCK; exit $?' INT TERM EXIT


rm -f $LOCK
        trap - INT TERM EXIT
fi
