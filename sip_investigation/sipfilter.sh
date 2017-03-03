#!/usr/bin/env bash

list=$(cat SIP_requests.txt | cut -f1)

for i in $list;
do
    tshark -r log.pcap -x -R frame.number==$i
done
