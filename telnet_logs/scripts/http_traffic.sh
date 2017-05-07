#!/bin/bash
# Sorts HTML traffic out of included telnet logs, first argument being the log to sort.
if [ "$#" -eq 1 ]; then
    IPS=$(grep -a 'GET\|HEAD\|CONNECT\|POST' "$1" | grep RECEIVED | cut -f10 -d' ' | sort -n | uniq)
    grep -a "$IPS" "$1" > HTTP_traffic.log
    grep -av "$IPS" "$1" > without_HTTP_traffic.log
fi
