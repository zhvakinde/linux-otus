#!/bin/bash
LOCK=/var/tmp/lockfile
WORKFILE=/vagrant/access.log
RESULTFILE=/vagrant/result
x=10
y=10

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
        ASTART=$(cat /var/log/cron | grep parse | sort | tail -1 | awk '{print $3}')
        AFINISH=$(date '+%H:%M:%S')
        echo "---" > $2
        echo "Log has been analyzed from $ASTART to $AFINISH" >> $2
        echo "---" >> $2
        echo "The list of addresses with the most requests to the server (top $x req-IP pairs)" >> $2
        cat $1 |awk '{print $1}' |sort |uniq -c |sort -rn| tail -$x >> $2
        echo "---" >> $2
        echo "The list of server resources with the most requests from the clients (top $y req-res pairs)" >> $2
        cat $1 |awk '{print $7}' |sort |uniq -c |sort -rn| tail -$y >> $2
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
cp $RESULTFILE /vagrant/log_parser_stat_$ASTART_$AFINISH
rm -f $RESULTFILE

rm -f $LOCK
        trap - INT TERM EXIT

exit 0
