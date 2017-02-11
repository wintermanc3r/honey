#!/bin/bash
echo "p0f OS detection sorted by number of packets (possibly) from each OS:"
./p0f -r $1 | grep ' os ' | grep -v '???' | tr -s ' ' | cut -d' ' -f4- | sort | uniq -c | sort -nr
