#!/bin/bash
# Grabs a list of all the connections made in a log, and the number
# of all succesful logins.
#
# Ex: ./all_connections overall.log

if [ "$#" -ne 1 ]; then
    echo Shows all connections made to the server.
    echo Usage: "$0" '<log>'
    exit -1
fi

ALL=$(cat "$1" | grep -a "Opened connection" | wc -l)
UNIQUE=$(cat "$1" | grep -a "Opened connection" | rev | cut -f1 -d' ' | rev | cut -f1 -d':' | sort -n | uniq | wc -l)
echo Total connections: $ALL Unique IPs: $UNIQUE

ALL=$(cat "$1" | grep -a "logged in" | wc -l)
UNIQUE=$(cat "$1" | grep -a "logged in" | cut -f8 -d' ' | cut -f1 -d':' | sort -n | uniq | wc -l)
echo Total logins: $ALL Unique IPs: $UNIQUE
