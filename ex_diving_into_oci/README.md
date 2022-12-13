## some oci stuff
#### digging into oci image
#### keep in mind to install the needed tools
#### jq skopeo psmisc tree
```
# mkdir data
```

#### copy image into oci structure
#### from docker registry
```
skopeo copy docker://alpine oci:local_alpine

```

#### content
```
tree --du local_alpine/
```

#### look into the index
```
cat local_alpine/index.json | jq
```

#### get the manifest from index and look into ("mediaType": "application/vnd.oci.image.manifest.v1+json")
#### example:
```
cat local_alpine/blobs/sha256/e7e08dedd97791cbbc86a40cc906d5f77c255d5f13ef9205b8af3a2860134737 | jq
```

#### get the image configuration from manifest and look into ("application/vnd.oci.image.config.v1+json")
#### example:
```
cat local_alpine/blobs/sha256/3fce28698f904c4ebc8cac6aef2fdf2671a1d7ebe121c042d81299e467899ee9 | jq
```

#### extract the files form the layers ("application/vnd.oci.image.layer.v1.tar+gzip")
#### example:
```
tar xf local_alpine/blobs/sha256/5814574988a88bbc539a544a1e29e52c7881705fc9696aac49179333ee97e7bf -C ./data/
```

