tshark -r log.pncap #specifies the input file to be read(-r)
tshark -r log.pncap -q -z "hosts"
tshark -r log.pcap -q -z "io,phs"
tshark -r log.pcap ip.addr == 172.89.89.47 >> ip_172.89.89.47

tshark -r log.pcap | cut -d '.' -f 2- | sed 's/  / /' | cut -d ' ' -f 2 | sort | uniq -c | sort -hr >> statistics  # IP address by popularity

tshark -r log.pcap| cut -d '.' -f 2- | sed 's/  / /' | cut -d ' ' -f 2-  | cut -d ' ' -f4 | sort | uniq -c | sort -hr >> statistics # Protocol
