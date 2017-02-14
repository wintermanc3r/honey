#!/usr/bin/env python2.7

import fileinput
import bgpranking_web
import sys

for line in fileinput.input():
    line = line.strip()
    tokens = line.split()
    if len(tokens) == 3:
        n = tokens[0]
        ip = tokens[1]
        asn = tokens[2]
        bgp_ranking = bgpranking_web.cached_position(asn)
        bgp_rank = bgp_ranking[0]
        print("{} {} {} {}".format(n, ip, asn, bgp_rank))
        sys.stdout.flush()
