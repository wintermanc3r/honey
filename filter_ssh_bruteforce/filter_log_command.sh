#!/bin/bash
tshark -r log.pcap | grep -v -f skip_ip > bruteforce_filtered_log
