#!/bin/bash -x

USER="hs"
HOST="$(uname -n)"
LOCAL_STORE="/home/${USER}/tools/docker-ws/ex_registry/store"
LOCAL_CERTS="/home/${USER}/tools/docker-ws/ex_registry/certs"
CRT="${HOST}.crt"
KEY="${HOST}.key"
MAPPED_PORT="5000"

ID=$(docker ps | grep registry | awk '{print $1}')
if [ "x${ID}" != "x" ]; then
	docker stop ${ID}
	docker rm ${ID}
fi

if [ ! -d ${LOCAL_CERTS} ]; then
        mkdir -p ${LOCAL_CERTS}
fi

if [ ! -d ${LOCAL_STORE} ]; then
        mkdir -p ${LOCAL_STORE}
fi

openssl req -new -newkey rsa:2048 -sha256 -nodes -x509 -keyout ${LOCAL_CERTS}/${KEY} -out ${LOCAL_CERTS}/${CRT} -addext "subjectAltName = DNS:${HOST}"
openssl x509 -in ${LOCAL_CERTS}/${CRT} -noout -text

if [ ! -d /etc/docker/certs.d/${HOST}:${MAPPED_PORT} ]; then
        mkdir -p /etc/docker/certs.d/${HOST}:${MAPPED_PORT}
fi
cp ${LOCAL_CERTS}/${CRT} /etc/docker/certs.d/${HOST}:${MAPPED_PORT}/ca.crt
chmod 0644 /etc/docker/certs.d/${HOST}:${MAPPED_PORT}/ca.crt
chown ${USER}: /etc/docker/certs.d/${HOST}:${MAPPED_PORT}/ca.crt

docker run -d --restart=always --name registry -v ${LOCAL_CERTS}:/certs -v ${LOCAL_STORE}:/var/lib/registry \
 -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/${CRT} \
 -e REGISTRY_HTTP_TLS_KEY=/certs/${KEY} -p ${MAPPED_PORT}:5000 registry:2
