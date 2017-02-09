#!/usr/bin/env python3

from urllib.request import urlopen
from urllib.error import HTTPError
from urllib.error import URLError
from bs4 import BeautifulSoup
import fileinput

url_ip_lookup = "http://bgpranking.circl.lu/ip_lookup?ip="
url_asn_details = "http://bgpranking.circl.lu/asn_details?asn="

def get_html(ip):
    try:
        html = urlopen(url_ip_lookup + ip)
    except HTTPError as e:
        #print(e)
        return None
    except URLError as e:
        #print("The server could bot be found")
        #print(e)
        return None
    return html

def get_asn(html):
    try:
        bs_object = BeautifulSoup(html.read(), "html5lib")
        links = bs_object.find("div", {"id": "content"}).ul.findAll("a")
    except AttributeError as e:
        return None        
    for link in links:
        link = link.get_text().strip()
        if link.isdigit():
            asn = link
            return asn
    return None

for line in fileinput.input():
    line = line.strip()
    tokens = line.split()
    if len(tokens) == 2:
        n = tokens[0]
        ip = tokens[1]
        print("{} {} ".format(n, ip), end="", )
        html = get_html(ip)
        if (html):
            asn = get_asn(html)
            if asn:
                print("{}".format(asn), flush=True)
            else:
                print("?a", flush=True)
        else:
            print("?h", flush=True)
