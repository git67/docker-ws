#!/bin/bash -x

USER="do"
HOST="dn"
REG_HOST="d-reg"
MAPPED_PORT="5000"



ssh ${USER}@${HOST} "sudo mkdir -p /etc/docker/certs.d/${REG_HOST}:${MAPPED_PORT}" 

scp /etc/docker/certs.d/${REG_HOST}:${MAPPED_PORT}/ca.crt ${USER}@${HOST}:~/

#ssh ${USER}@${HOST} "sudo chown ${USER}: ${USER}@${HOST}:~/ca.crt"

ssh ${USER}@${HOST} "sudo cp ~/ca.crt /etc/docker/certs.d/${REG_HOST}:${MAPPED_PORT}/"
ssh ${USER}@${HOST} "sudo chown ${USER}: /etc/docker/certs.d/${REG_HOST}:${MAPPED_PORT}/*"
