#!/bin/bash
p0f -r $1 | grep 'Linux 2' -B4 | grep '\[' | cut -d'/' -f3 | cut -d' ' -f1 >> older_linux_traffic_by_port
p0f -r $1 | grep 'bare' -B4 | grep '\[' | cut -d'/' -f3 | cut -d' ' -f1 >> older_linux_traffic_by_port
cat older_linux_traffic_by_port | sort -n | uniq -c | sort -nr >> older_linux_traffic_by_port
