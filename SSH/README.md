### SSH and Alternative protocol notes

*Overview:* 617,694 total packets:
	    36,987 non-TCP packets (6% of total)
	    	   Other major protocols:
	    	   DNS: 28,713 (4.6% of total)
		   ARP: 6,674 (1.2%)
		   ICMP: 334 (.1%)


#### SSH Analysis

The 'AS_IP_table' file contains a table with information related to
each of the SSH attempt destination IPs. The table includes:
* AS
* IP
* BGP Prefix
* Country
* Registry
* Allocated
* AS Name
* Number of SSH attempts

The table can be rebuilt by:
* exec AS_lookup.py for the look up information
* exec AS_results_parse.py to clean the look up information
* exec count_append.py to add the number of associated IP attempts as a new column to the table



Below is a table of the IP addresses that exchanged SSH packets. For all IPs where count(SSH packets) < 10, the IP was looked up in the authlog and in pcap to look for anomolous information.


IPs that transmitted SSH packet

|Source		   |Count| Notes     |
|------------------|-----|---------  |
|112.217.150.112|14|
|112.85.42.124|452
|115.197.192.51|10
|115.204.21.209|10
|116.31.116.17|47290|China
|118.255.205.246|10
|118.33.200.205|10
|119.249.54.71|1775
|121.18.238.104|781
|121.18.238.109|979
|121.18.238.114|474
|121.18.238.98|443
|122.179.161.89|10
|138.68.14.38|49
|153.99.182.21|53
|172.89.89.47|114859|Self
|177.54.225.78|10
|181.57.149.131|10
|182.47.136.180|10
|190.117.247.204|10
|193.250.18.202|10
|200.124.227.164|10
|207.204.227.131|4
|210.209.93.40|17
|221.194.44.195|909
|221.194.44.219|376
|221.194.44.224|695
|221.194.44.231|851
|221.194.47.208|1107
|221.194.47.224|430
|221.194.47.249|453
|58.218.204.183|32553|China
|58.218.204.66|50755|China
|60.185.161.239|1
|60.239.96.63|10
|71.6.146.185|6
|79.185.167.48|8
|80.178.124.82|11
|Total Result|255465

IPs with less than 10 SSH packets
|Source		   |Count| Notes     |
|------------------|-----|---------  |
|60.185.161.239    |1    |China. authlog: connection closed |
|71.6.146.185      |6    |San Diego. authlog: connection closed * 2 |
|79.185.167.48     |8    |Warsaw. authlog: failed pwd for root, max root attempts exceeded |
|207.204.227.131   |4    |San Fran. authlog: connection closed |
