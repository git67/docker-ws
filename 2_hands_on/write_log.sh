#!/usr/bin/bash

while true
do
	echo ${RANDOM} | md5sum | head -c 20; echo;
done
