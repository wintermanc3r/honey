#!/usr/bin/env bash
# Command started on March 6, 2017 at 18:45
# install docker
sudo apt-get install docker docker.io
# clone glastopf honeypot
git clone https://github.com/mushorg/glastopf
cd glastopf
# build the docker container
sudo docker build --tag glastopf .
# create a directory for our logs and configs
mkdir myhoneypot1
# run the docker container
sudo docker run --detach --publish 80:80 --volume myhoneypot1:/opt/myhoneypot glastopf
# create the log file manually
touch http_log.pcap
# change owner to root because we run tshark in root
sudo chown root:root http_log.pcap
# run tshark in the background as sudo and filter port 80
sudo tshark -w http_log.pcap "port 80 or port 8080 or port 443" &
