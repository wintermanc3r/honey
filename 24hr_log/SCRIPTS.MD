To get all by TCP destination port:
tshark -r log.pcap -n -z conv,tcp -q > formatted.output
cat formatted.output | tr -s ' ' | cut -d' ' -f3 | grep 172.89.89.47 | cut -d':' -f2  >> output_by_ports

To get all by UDP destination port:
tshark -r log.pcap -n -z conv,udp -q > formatted.udpoutput
cat formatted.output | tr -s ' ' | cut -d' ' -f3 | grep 172.89.89.47 | cut -d':' -f2  >> output_by_ports