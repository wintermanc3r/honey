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

## To Do
- [ ] Parse through the logs, and organize them by number of IP requests, type of request, or number of requests by country.
- [ ] Decide on what kind of honey pot to set up.
  * IOT - Specifically Mirai Botnet type.
  * What's out there?

## Links
For a list of resources and commands used, refer to [LINKS.md](LINKS.md)

## Authors
For a list of Authors and contributors, refer to [AUTHORS](AUTHORS)
