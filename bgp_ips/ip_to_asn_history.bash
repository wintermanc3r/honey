#!/usr/bin/env bash
# https://www.circl.lu/services/ip-asn-history/
cat unique_ips | rev | cut -f1 -d ' ' | rev | xargs -n1 whois -h whois.circl.lu
