#!/bin/bash

while true
do
	
	if [[ -f /root/index.html ]]; then
		rm /root/index.html;
	fi

	wget -q -P /root/index.html websrv:80;

	CHANGES=$(diff /root/assets/index.html /root/index.html);

	cp /root/assets/index.html /tmp/ch.html

	echo "<h1> $(date) </h1>" >> /tmp/ch.html

	if [[ -n "${CHANGES}" ]]; then
		scp /tmp/ch.html root@websrv:/var/www/html/index.nginx-debian.html
	fi
done
