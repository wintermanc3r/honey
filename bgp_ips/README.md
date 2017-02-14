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

## 3. Getting the bgp scores

Requirements: Install the CIRCL [BGP Ranking Python API](https://github.com/CIRCL/bgpranking-redis-api/tree/master/example/api_web/client/bgpranking_web). [Read more](https://www.circl.lu/projects/bgpranking/).

The script `ip_to_bgp_ranking.py` gets the content of a `ip_asn.txt`-like file and adds the bgp ranking as a 4th column.

```
$ cat ip_asn.txt | ./ip_to_bgp_ranking.py  > ip_asn_bgp.txt
```

_Note_: We did run the script on 2/13/2017 - At that time, there were 13043 AS in CIRCL listing.

### 4. Sorting by bgp score


```
$ cat ip_asn_bgp.txt | ./sort_ip_asn_bgp_by_bgp.bash > ip_asn_bgp_sorted.txt
```

Top top in our pcap file:

```
$ head ip_asn_bgp_sorted.txt
2 91.200.12.160 43765 0
2 191.96.249.117 64484 2
2 191.96.249.42 64484 2
29 185.169.229.182 206975 10
1 185.56.82.30 60115 14
2 185.56.82.14 60115 14
5 91.211.0.31 48422 43
3 37.49.224.130 133229 84
1 185.169.231.24 206976 106
1 80.82.64.68 29073 113
```

See file `ip_asn_bgp_sorted.txt` for complete list.
