#!/bin/bash
tshark -r log.pcap | grep -v -f brute_forcing_ips | cut -d '.' -f 2- | sed 's/  / /' | cut -d ' ' -f 2-  | cut -d ' ' -f4 | sort | uniq -c | sort -hr > protocolStats_w-o_filteredIps
