#!/bin/bash

curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X GET https://d-reg:5000/v2/_catalog

curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X GET https://d-reg:5000/v2/develop/nginx/tags/list

curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X GET https://d-reg:5000/v2/develop/nginx/manifests/latest

curl --head -H application/vnd.docker.distribution.manifest.v2+json --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X GET https://d-reg:5000/v2/develop/nginx/manifests/latest |jq

## curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X DELETE https://d-reg:5000/v2/httpd/manifests/sha256:1dc61f5a5f3ddc2a81be7eb3b2ba5dfbac49f49f69d429ea4f3ae77a7ea2f768


