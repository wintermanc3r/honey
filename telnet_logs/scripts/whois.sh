#!/bin/bash
# Run against a list of IPs to get whois information (top 10 ASNs,
# top 10 countries) for the list. Use all_ips to get ips first.
# Run with all as an option to print all rather than top 10.
#
# Ex: ./whois.sh <ips> <option>
# Ex: ./whois.sh all_ips all
if [ "$#" -lt 1 ]; then
    echo Run on a list of line separated IPs.
    echo Usage: "$0" '<ip_list> <option>'
    echo Only option is all, to print all info. Default prints top 10.
    exit -1
fi
PRINTALL=0
if [ "$#" -eq 2 ]; then
    if [ "$2" = 'all' ]; then
	(>&2 echo "Printing all...")
	PRINTALL=1
    fi
fi
touch whois.tmp
(>&2 echo "This may take a minute...")
while read line
do
    whois -h whois.cymru.com "-v $line" | tail -1 >> whois.tmp
done < "$1"

ALL=$(cut -d'|' -f1,4,7 whois.tmp | sort -nr | uniq -c | sort -nr)
COUNTRIES=$(cut -d'|' -f1,4,7 whois.tmp | sort -nr | cut -d'|' -f4 whois.tmp | sort | uniq -c | sort -nr)
if [ "$PRINTALL" -eq "1" ]; then
    echo All ASNs:
    echo "$ALL"
    echo All Countries:
    echo "$COUNTRIES"
else
    echo Top 10 ASNs:
    echo "$ALL" | head
    echo Top 10 Countries:
    echo "$COUNTRIES" | head
fi

rm whois.tmp
