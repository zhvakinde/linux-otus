#!/bin/bash
LOCK=/var/tmp/lockfile
WORKFILE=/vagrant/access.log
RESULTFILE=/vagrant/result

if [ -f $LOCK ]
then
        echo "File is busy"
        exit 1
else
        touch $LOCK
        trap 'rm -f $LOCK; exit $?' INT TERM EXIT
fi

analyse() {
        FTARGETFILE=$1
        FRESULTFILE=$2
        ASTART=`head -n 1 $1 |awk '{print $4,$5}'`
        AFINISH=`tail -n 1 $1 |awk '{print $4,$5}'`
        echo "---" > $2
        echo "Log has been analyzed from $ASTART to $AFINISH" >> $2
        echo "---" >> $2
        echo "The list of addresses with the most requests to the server (top 10 req-IP pairs)" >> $2
        cat $1 |awk '{print $1}' |sort |uniq -c |sort -rn| head >> $2
        echo "---" >> $2
        echo "The list of server resources with the most requests from the clients (top 10 req-res pairs)" >> $2
        cat $1 |awk '{print $7}' |sort |uniq -c |sort -rn| head >> $2
        echo "---" >> $2
        echo "Total number of errors (status codes 4xx and 5xx, number-code pairs)" >> $2
        cat $1 |awk '{print $9}' |grep -E "[4-5]{1}[0-9][0-9]" |sort |uniq -c |sort -rn >> $2
        echo "---" >> $2
        echo "The list of status codes with their total number (number-code pairs)" >> $2
        cat $1 |awk '{print $9}' |sort |uniq -c |sort -rn >> $2
        echo "---" >> $2
}
analyse $WORKFILE $RESULTFILE
cat $RESULTFILE | mail -s "Message fron NGINX parser" admin@test.ru


rm -f $LOCK
        trap - INT TERM EXIT

