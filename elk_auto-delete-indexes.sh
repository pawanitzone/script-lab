#!/bin/bash


#ELKMASTER=ev2b469.tpp.tsysecom.com
#Add days for how many days we wan to keep this data
DAYSAGO=`date --date="15 days ago" +%Y%m%d`
ALLLINES=`/usr/bin/curl -s -XGET http://$ELKMASTER:9200/_cat/indices?v | egrep logstash`

echo
echo "THIS IS WHAT SHOULD BE DELETED FOR ELK:"
echo

echo "$ALLLINES" | while read LINE
do
  FORMATEDLINE=`echo $LINE | awk '{ print $3 }' | awk -F'-' '{ print $2 }' | sed 's/\.//g' ` 
  if [[ "$FORMATEDLINE" -lt "$DAYSAGO" ]]
  then
    TODELETE=`echo $LINE | awk '{ print $3 }'`
    echo "http://$ELKMASTER:9200/$TODELETE"
    /usr/bin/curl -XDELETE http://$ELKMASTER:9200/$TODELETE
    sleep 1
  fi
done
