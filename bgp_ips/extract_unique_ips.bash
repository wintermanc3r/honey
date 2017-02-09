#!/usr/bin/env bash
tshark -r log.pcap | cut -d '.' -f 2- | sed 's/  / /' | cut -d ' ' -f 2  | sort | uniq -c > unique_ips.txt
