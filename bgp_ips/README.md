# Analysing ASN of IPs (from pcap)

## 0. Extract unique IPs from the pcap file

Requirement: you need the `log.pcap` file. Feel free to use yours and update the name of the file in the following script

```
$ ./extract_unique_ips.bash > unique_ips.txt
```

The above command line generates a file called `unique_ips.txt`. Feel free to change the name of this file in the above command line. The format of the output (here the file) is:

- number of packets
- unique IP address

See file `unique_ips.txt`.

## 1. Get the ASN from the IP

The script `./ip_to_asn.py` is scraping the website(*) [CIRCL](http://bgpranking.circl.lu/) to get the ASN attached to the IP.

Requirement: you need a file with the same format as the file `unique_ips.txt` (see above)

```
cat unique_ips.txt | ./ip_to_asn.py > ip_asn.txt
```

Output format:

- number of packets
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

## 4. Sorting by bgp score


```
$ cat ip_asn_bgp.txt | ./sort_ip_asn_bgp_by_bgp.bash > ip_asn_bgp_sorted.txt
```

Format:

- number of packets
- unique IP address
- ASN of the IP address
- BGP score

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

## 5. Top BGP

### 5.0 91.200.12.160 (bgp score = 0/13043)

```
258041 39317.390878000 91.200.12.160 -> 172.89.89.47 TCP 54 55919 > ms-wbt-server [SYN] Seq=0 Win=1024 Len=0
258042 39317.390913000 172.89.89.47 -> 91.200.12.160 TCP 54 ms-wbt-server > 55919 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
258047 39317.538517000 91.200.12.160 -> 172.89.89.47 TCP 54 55919 > ms-wbt-server [RST] Seq=1 Win=1200 Len=0
```

- ms-wbt-server: ms-wbt-server is a common name for a protocol that is used by Windows Remote Desktop and uses the well known TCP port 3389

### 5.1 191.96.249.117 (bgp score: 2/13043)

```
77419 11997.808781000 191.96.249.117 -> 172.89.89.47 TCP 54 51386 > smtp [SYN] Seq=0 Win=1024 Len=0
77420 11997.808842000 172.89.89.47 -> 191.96.249.117 TCP 54 smtp > 51386 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
77421 11997.924925000 191.96.249.117 -> 172.89.89.47 TCP 54 51386 > smtp [RST] Seq=1 Win=1200 Len=0
```

### 5.2 191.96.249.42 (bgp score: 2/13043)

```
7781 1139.574494000 191.96.249.42 -> 172.89.89.47 TCP 54 44939 > 49152 [SYN] Seq=0 Win=1024 Len=0
7782 1139.574520000 172.89.89.47 -> 191.96.249.42 TCP 54 49152 > 44939 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
7783 1139.743561000 191.96.249.42 -> 172.89.89.47 TCP 54 44939 > 49152 [RST] Seq=1 Win=1200 Len=0
```

Note: The range 49152–65535 contains dynamic or private ports that cannot be registered with IANA. This range is used for private, or customized services or temporary purposes and for automatic allocation of ephemeral ports.

Note2:

- [Exploiting bug in Supermicro hardware is as easy as connecting to port 49152.](https://arstechnica.com/security/2014/06/at-least-32000-servers-broadcast-admin-passwords-in-the-clear-advisory-warns/)
- [OS-Command Injection via UPnP Interface in multiple D-Link devices](http://www.s3cur1ty.de/node/714)

### 5.3 185.169.229.182 (bgp score: 10/13043)

```
6134 897.087360000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > http [SYN] Seq=0 Win=1024 Len=0
6135 897.087415000 172.89.89.47 -> 185.169.229.182 TCP 54 http > 53535 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
6139 897.281167000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > http [RST] Seq=1 Win=1200 Len=0
49195 7353.786956000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > 8089 [SYN] Seq=0 Win=1024 Len=0
49196 7353.787016000 172.89.89.47 -> 185.169.229.182 TCP 54 8089 > 53535 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
49197 7353.926054000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > 8089 [RST] Seq=1 Win=1200 Len=0
75946 11763.161259000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > http-alt [SYN] Seq=0 Win=1024 Len=0
75947 11763.161308000 172.89.89.47 -> 185.169.229.182 TCP 54 http-alt > 53535 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
75948 11763.411537000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > http-alt [RST] Seq=1 Win=1200 Len=0
98845 15330.115155000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > 81 [SYN] Seq=0 Win=1024 Len=0
98846 15330.115190000 172.89.89.47 -> 185.169.229.182 TCP 54 81 > 53535 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
141079 22095.815613000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > irdmi [SYN] Seq=0 Win=1024 Len=0
141080 22095.815675000 172.89.89.47 -> 185.169.229.182 TCP 54 irdmi > 53535 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
141081 22095.971130000 185.169.229.182 -> 172.89.89.47 TCP 54 53535 > irdmi [RST] Seq=1 Win=1200 Len=0
213065 32170.481935000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > irdmi [SYN] Seq=0 Win=1024 Len=0
213066 32170.481984000 172.89.89.47 -> 185.169.229.182 TCP 54 irdmi > 46360 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
240389 36602.919442000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > http [SYN] Seq=0 Win=1024 Len=0
240390 36602.919499000 172.89.89.47 -> 185.169.229.182 TCP 54 http > 46360 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
240391 36603.332401000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > http [RST] Seq=1 Win=1200 Len=0
240434 36622.896053000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > xfer [SYN] Seq=0 Win=1024 Len=0
240435 36622.896102000 172.89.89.47 -> 185.169.229.182 TCP 54 xfer > 46360 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
330067 49688.457150000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > 8089 [SYN] Seq=0 Win=1024 Len=0
330068 49688.457172000 172.89.89.47 -> 185.169.229.182 TCP 54 8089 > 46360 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
330074 49688.703465000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > 8089 [RST] Seq=1 Win=1200 Len=0
351679 52893.002085000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > http-alt [SYN] Seq=0 Win=1024 Len=0
351680 52893.002135000 172.89.89.47 -> 185.169.229.182 TCP 54 http-alt > 46360 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
351684 52893.157006000 185.169.229.182 -> 172.89.89.47 TCP 54 46360 > http-alt [RST] Seq=1 Win=1200 Len=0
409832 62420.595344000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > http-alt [SYN] Seq=0 Win=1024 Len=0
409833 62420.595393000 172.89.89.47 -> 185.169.229.182 TCP 54 http-alt > 59307 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
409834 62420.751611000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > http-alt [RST] Seq=1 Win=1200 Len=0
453576 69090.794981000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > http [SYN] Seq=0 Win=1024 Len=0
453577 69090.795039000 172.89.89.47 -> 185.169.229.182 TCP 54 http > 59307 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
453578 69090.975745000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > http [RST] Seq=1 Win=1200 Len=0
494520 73892.731935000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > xfer [SYN] Seq=0 Win=1024 Len=0
494521 73892.731979000 172.89.89.47 -> 185.169.229.182 TCP 54 xfer > 59307 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
494532 73893.040411000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > xfer [RST] Seq=1 Win=1200 Len=0
522034 76966.703499000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > irdmi [SYN] Seq=0 Win=1024 Len=0
522035 76966.703557000 172.89.89.47 -> 185.169.229.182 TCP 54 irdmi > 59307 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
522047 76966.831604000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > irdmi [RST] Seq=1 Win=1200 Len=0
574479 83110.109800000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > 81 [SYN] Seq=0 Win=1024 Len=0
574480 83110.109850000 172.89.89.47 -> 185.169.229.182 TCP 54 81 > 59307 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
574482 83110.396937000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > 81 [RST] Seq=1 Win=1200 Len=0
577422 83517.345700000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > 8089 [SYN] Seq=0 Win=1024 Len=0
577423 83517.345732000 172.89.89.47 -> 185.169.229.182 TCP 54 8089 > 59307 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
577427 83517.477689000 185.169.229.182 -> 172.89.89.47 TCP 54 59307 > 8089 [RST] Seq=1 Win=1200 Len=0
```

Notes:

- `irdmi`: iRDMI (Intel Remote Desktop Management Interface) - sometimes erroneously used instead of port 8080 (Unofficial) Commonly used for internet radio streams such as those using SHOUTcast (Unofficial)
- `8089`: Splunk daemon management | Fritz!Box automatic TR-709 configuration
- `81`: TorPark onion routing
- `xfer`: port 82, [unknown](https://www.grc.com/port_82.htm)

Probably only http scan: 80 +- 1, 2 && 8080 +1

### 5.4 185.56.82.30 (bgp score: 10/13043)

```
439841 67002.086905000 185.56.82.30 -> 172.89.89.47 TCP 62 21539 > rfb [SYN] Seq=0 Win=65535 Len=0 MSS=1460 SACK_PERM=1
439842 67002.086926000 172.89.89.47 -> 185.56.82.30 TCP 54 rfb > 21539 [RST, ACK] Seq=1 Ack=1 Win=0 Len=0
```

- `rfb`: RFB (“remote framebuffer”) is a simple protocol for remote access to graphical user interfaces - Now used by `VNC`
