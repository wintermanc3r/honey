#!/usr/bin/env python3

import fileinput
import operator

asn_report = {}
for line in fileinput.input():
    line = line.strip()
    tokens = line.split()
    if len(tokens) == 3:
        n = tokens[0]
        ip = tokens[1]
        asn = tokens[2]
        if asn[0] != "?":
            if asn in asn_report:
                asn_report[asn] += 1
            else:
                asn_report[asn] = 1

sorted_asn_report = sorted(asn_report.items(), key=operator.itemgetter(1), reverse=True)

for asn_ip in sorted_asn_report:
    print("{} {}".format(asn_ip[0], asn_ip[1]))
