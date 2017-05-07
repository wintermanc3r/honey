#!/bin/bash
# Uses the torproject Exonerator to check if IPs in a list of IPs were
# being used as a public Tor exit node on a given day, give or take
# 24 hrs.
#
# Use all_ips.sh to generate a list of IPs from a log, then use this.
# Ex: ./all_ips.sh overall.log > all_ips;./exit_node_check.sh overall.log 2017-03-31
if [ "$#" -ne 2 ]; then
    echo Usage: '"$0" <ips> <date>'
    echo Use with ./all_ips or use any line seperated list of IPs
    echo 'Ex: ./exit_node_check.sh $(./all_ips overall.log) 2017-03-31'
    exit -1
fi

while read line
do
    URL="https://exonerator.torproject.org/?ip=$line&timestamp=$2"
    RESULT=$(curl -s "$URL" | grep "positive" | echo $?)
    if [[ $RESULT -eq 0 ]]; then
       echo Found "$line" within 24-hrs of "$2". Check "$URL" for details.
    else
	echo "$line" not found.
    fi
done < "$1"
