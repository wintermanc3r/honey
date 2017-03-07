# Holberton School - Honey Pot Project
<em>2017, January 27 - ongoing</em>
This repo is for a honeypot project, created with the aim of writing a white paper focusing on unsolicited internet traffic.
This project is a joint effort between [Holberton School](https://www.holbertonschool.com/) staff, students, and mentors.

## Process:
0. Setup an [Amazon AWS instance](https://aws.amazon.com/)
1. Install [tshark](https://www.wireshark.org/docs/man-pages/tshark.html): `sudo apt-get install tshark`
2. Setup an ssh tunneling server, so we only have to filter one IP address, and only have one ssh entry way into the Amazon AWS instance. We used a droplet from [Digital Ocean](https://www.digitalocean.com/).
3. Filter out all traffic from our IP address `sudo tshark -w log.pcap -s 0 -n -f 'not net <IP from ssh tunnel>'`
4. Record the activity for one day.
5. Parse through the pcap, organize them by number of IP requests, type of request, or number of requests by country.
6. Decide on what kind of honey pot to set up, based on the top accessed protocols.
  * TELNET (port 23) - Specifically targeted at Mirai/Hijimbe
    * Cowrie, homegrown honeypot
  * SIP (port 5060 + 5061)
    * Artemesia, Dionisia, homegrown honeypot
  * HTTP + MySQL (port 80 + 3306) - Specifically Wordpress, MySQL
    * Glasopf, homegrown honeypot
  * One other protocol
7. Compare the pcap with auth.log from that day to determine what is ssh bruteforce and what is not.

## To Do
* [ ] -- Swati and Ian L-J: Research and deploy SIP honeypot
* [ ] -- Ian C: Write the paper and organize the data

## Installed packages / honeypots:
* tshark
* docker
* cowrie

## Links
For a list of resources and commands used, refer to [LINKS.md](LINKS.md)
* [Google Doc for Protocol Descriptions](https://docs.google.com/document/d/1vn0ldHN5CXYHD-qw00mlW5jAQoDzhniDeXI5yQ-Hapo/edit)

## Authors
For a list of Authors and contributors, refer to [AUTHORS](AUTHORS)
