#!/bin/bash
# Grabs all unique IPs from a log.
#
# Ex: ./all_ips overall.log > all_ips
if [ "$#" -ne 1 ]; then
    echo Gets a list of all unique IPs in a log.
    echo Usage: "$0" '<log>'
    exit -1
fi
cat "$1" | grep -a Opened | rev | cut -f1 -d' ' | rev | cut -f1 -d':' | sort -nr | uniq
