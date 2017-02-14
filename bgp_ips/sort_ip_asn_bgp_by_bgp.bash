#!/usr/bin/env bash
sort -k 4 -n ip_asn_bgp.txt  | grep -v "None"
