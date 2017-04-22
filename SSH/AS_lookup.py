#!/usr/bin/python3

#from subprocess import call
import os

ip_list = []
with open("SSH_IP_LIST", "r") as f:
    for line in f:
        ip_list.append(line)

#for ip in ip_list:
#    call(['whois', '-h', 'whois.cymru.com " -v {}"'.format(ip)])

for ip in ip_list:
    os.system('whois -h whois.cymru.com " -v {}"'.format(ip))
#sample command for whois AS lookup
#whois -h whois.cymru.com " -v 216.90.108.31 2005-12-25 13:23:01 GMT"
