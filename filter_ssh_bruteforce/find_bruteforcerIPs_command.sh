#!/bin/bash
grep -E 'Failed|failures' /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq > brute_forcing_ips
