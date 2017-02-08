#!/bin/bash
tshark -r log.pcap | grep -v -f brute_forcing_ips > bruteforce_filtered_log
