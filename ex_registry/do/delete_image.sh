#!/bin/bash -x


export REGISTRY_STORAGE_DELETE_ENABLED=true
registry='d-reg:5000'
images=${1:-patch/nginx}


for image in $images; do
    echo "DELETING: " $image

    # get tag list of image, with fallback to empty array when value is null
    tags=$(curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt "https://${registry}/v2/${image}/tags/list" | jq -r '.tags // [] | .[]' | tr '\n' ' ')

    # check for empty tag list, e.g. when already cleaned up
    if [[ -n $tags ]]
    then
        for tag in $tags; do
            curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X DELETE "https://${registry}/v2/${image}/manifests/$(
                curl  --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -I \
                    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
                    "https://${registry}/v2/${image}/manifests/${tag}" \
                | awk '$1 == "docker-content-digest:" { print $2 }' \
                | tr -d $'\r' \
            )"
        done

        echo "DONE:" $image
    else
        echo "SKIP:" $image
    fi
done


curl --cacert /etc/docker/certs.d/d-reg\:5000/ca.crt -X GET https://d-reg:5000/v2/_catalog

