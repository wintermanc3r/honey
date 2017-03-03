#!/usr/bin/env bash
# prints out information about the sip packets.
if [[ ! "$#" -eq 1 ]]; then
	echo "Usage: ./info_about_sip.sh <file.pcap>"
else
	tshark -r $1 -n -e frame.number -e ip.src -e ip.dst -e udp.dstport -e sip.r-uri -T fields "sip" -P
fi
