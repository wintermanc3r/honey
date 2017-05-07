#!/bin/bash
# Grabs a list of username/passwords from a log.
#
# Ex: ./password_count.sh <logs>
if [ "$#" -ne 1 ]; then
    echo Usage: "$0" '<log>'
    exit -1
fi
ALL=$(grep -a "logged in as" "$1" | rev | cut -d' ' -f1 | rev | sort)
USER=$(echo "$ALL" | tr -s ' '  | cut -f3 -d' ' | cut -f1 -d'-')
PASSWORD=$(echo "$ALL"| tr -s ' '  | cut -f3 -d' ' | cut -f2 -d'-')
echo Top 5 Username/Passwords:
echo "$ALL" | sort | uniq -c | sort -nr | head -5
echo Top 5 User Names:
echo "$USER" | sort | uniq -c | sort -nr | head -5
echo Top 5 Passwords:
echo "$PASSWORD" | sort | uniq -c | sort -nr | head -5
