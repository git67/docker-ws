#!/usr/bin/bash

while true
do
	echo $(curl http://nginx)
	sleep 5
done

exit 0
