#!/usr/bin/python3

attempts = ["Attempts", 14,452,10,10,47290,10,10,1775,781,979,474,443,10,49,53,114859,10,10,10,10,10,10,4,17,909,376,695,851,1107,430,453,32553,50755,1,10,6,8,11]

with open('AS_results_cleaned', 'r') as f:
    ipfile = f.read()

ipfile_list = ipfile.split('\n')
with open('AS_IP_table', 'a+') as l:
    line = 0
    while line < len(attempts):
        line_length = len(ipfile_list[line])
        l.write(ipfile_list[line] + ((154 - line_length) * ' ') + '| ' + str(attempts[line]) + '\n')
        line += 1
