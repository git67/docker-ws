## 2_hands_on
#### create a simple image with running shell-script within
```
docker build . -t 2_hands_on:1.0
docker images
```

#### run the image named as  "log"
```
docker run -d --name log 2_hands_on:1.0
docker ps
```

#### inspect the log written by the injected script
```
docker logs -f log
sudo tail -f $(docker inspect -f {{.LogPath}} log)
```

#### clean up
```
docker ps
docker stop log
docker rm log
docker ps -a
docker images
docker rmi $(docker images -qa)
docker images
```

