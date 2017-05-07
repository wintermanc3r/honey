#!/bin/bash
# Grabs a count of bots from a given log.
# Ex: ./bot_count overall.log > bot_count

if [ "$#" -ne 1 ]; then
    echo Usage: "$0" '<log>'
    exit -1
fi

FILE=$(<"$1")
print_connections() {
TOTAL=$(echo "$FILE" | grep -a "$1" | cut -f10 -d' ' | wc -l)
UNIQUE=$(echo "$FILE" | grep -a "$1" | cut -f10 -d' ' | sort -n | uniq | wc -l)
echo --------------------------------------
echo $2 connections:
echo Total connections: "$TOTAL"
echo Unique IPs: "$UNIQUE"
}

print_connections "MIRAI" "Mirai scanner"
print_connections "/bin/busybox ps; /bin/busybox ECCHI" "Mirai/Ecchi downloader"
print_connections "OBJPRN" "OBJPRN Mirai variant"
print_connections "(dd bs=52 count=1 if=" "Hajime downloader"
print_connections "/bin/busybox cp /bin/busybox" "Mirai 'xkajdnabw' variant"
print_connections "rm -fr /tmp; mkdir /tmp; cd /tmp; wget" "Trojan.Downloader.BashAgent.LO"
print_connections "cd /tmp || cd /var/run ||" "Trojan.Downloader.BashAgent.DO"
print_connections '\\\\147\\\\141\\\\171\\\\146\\\\147\\\\164' "gafgyt"

echo --------------------------------------
