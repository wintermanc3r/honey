# Analysing ASN of IPs (from pcap)

## 0. Extract unique IPs from the pcap file

Requirement: you need the `log.pcap` file. Feel free to use yours and update the name of the file in the following script

```
$ ./extract_unique_ips.bash > unique_ips.txt
```

The above command line generates a file called `unique_ips.txt`. Feel free to change the name of this file in the above command line. The format of the output (here the file) is:

- number of requests
- unique IP address

See file `unique_ips.txt`.

## 1. Get the ASN from the IP

The script `./ip_to_asn.py` is scraping the website(*) [CIRCL](http://bgpranking.circl.lu/) to get the ASN attached to the IP.

Requirement: you need a file with the same format as the file `unique_ips.txt` (see above)

```
cat unique_ips.txt | ./ip_to_asn.py > ip_asn.txt
```

Output format:

- number of requests
- unique IP address
- ASN of the IP address

(*) Note: we should have had use the cleaner whois method (see [CIRCL](https://www.circl.lu/services/ip-asn-history/)).
See script `ip_to_asn_history.bash` for an example on how to use the `whois` method.

## 2. IPs per ASN

The script `./gen_asn_report.py` generates a listing of how many IPs per ASN did send requests to our server

```
cat ip_asn.txt | ./gen_asn_report.py > report_unique_ips_per_asn.txt
```

Output format:

- number of requests
- ASN

_Note_: There were 4 IPs we could not get an ASN for, with our methodology, in our pcap file:

```
$ grep "?a" ip_asn.txt
1 158.250.235.16 ?a
1 227.89.91.227 ?a
1 240.113.214.171 ?a
1 250.98.21.89 ?a
```
