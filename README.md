Simple docker image for fastestvpn.com provider. Used for linking transmission and other containers.

This is inspired by https://hub.docker.com/r/haugene/transmission-openvpn

Documentation for variables below can be found in the link - https://haugene.github.io/docker-transmission-openvpn/

```bash
docker run --name vpn --cap-add=NET_ADMIN -d
--restart unless-stopped
-v /etc/localtime:/etc/localtime:ro
-e OPENVPN_USERNAME=<your-user-name>
-e OPENVPN_PASSWORD=<your-password>
-e OPENVPN_CONFIG=australia1-tcp.ovpn,australia1-udp.ovpn,australia2-tcp.ovpn,australia2-udp.ovpn,austria-tcp.ovpn,austria-udp.ovpn,belgium1-tcp.ovpn,belgium1-udp.ovpn,brazil-tcp.ovpn,brazil-udp.ovpn,bulgaria-tcp.ovpn,bulgaria-udp.ovpn,canada1-tcp.ovpn,canada1-udp.ovpn,canada-stream-tcp.ovpn,canada-stream-udp.ovpn,colombia-tcp.ovpn,colombia-udp.ovpn,czechia-tcp.ovpn,czechia-udp.ovpn,denmark-tcp.ovpn,denmark-udp.ovpn,finland1-tcp.ovpn,finland1-udp.ovpn,finland2-tcp.ovpn,finland2-udp.ovpn,france-tcp.ovpn,france-udp.ovpn,germany1-tcp.ovpn,germany1-udp.ovpn,germany-dus1-tcp.ovpn,germany-dus1-udp.ovpn,germany-dus2-tcp.ovpn,germany-dus2-udp.ovpn,greece-tcp.ovpn,greece-udp.ovpn,hongkong-tcp.ovpn,hongkong-udp.ovpn,hungary-tcp.ovpn,hungary-udp.ovpn,india1-tcp.ovpn,india1-udp.ovpn,india-stream-tcp.ovpn,india-stream-udp.ovpn,ireland-tcp.ovpn,ireland-udp.ovpn,italy1-tcp.ovpn,italy1-udp.ovpn,italy-stream-tcp.ovpn,italy-stream-udp.ovpn,japan1-tcp.ovpn,japan1-udp.ovpn,japan2-tcp.ovpn,japan2-udp.ovpn,japan-stream-tcp.ovpn,japan-stream-udp.ovpn,luxembourg-tcp.ovpn,luxembourg-udp.ovpn,malaysia-tcp.ovpn,malaysia-udp.ovpn,mexico-tcp.ovpn,mexico-udp.ovpn,netherlands1-tcp.ovpn,netherlands1-udp.ovpn,netherlands2-tcp.ovpn,netherlands2-udp.ovpn,norway-tcp.ovpn,norway-udp.ovpn,poland-tcp.ovpn,poland-udp.ovpn,portugal-tcp.ovpn,portugal-udp.ovpn,romania-tcp.ovpn,romania-udp.ovpn,russia-tcp.ovpn,russia-udp.ovpn,serbia-tcp.ovpn,serbia-udp.ovpn,singapore-tcp.ovpn,singapore-udp.ovpn,slovakia-tcp.ovpn,slovakia-udp.ovpn,southafrica-tcp.ovpn,southafrica-udp.ovpn,southkorea1-tcp.ovpn,southkorea1-udp.ovpn,southkorea-stream-tcp.ovpn,southkorea-stream-udp.ovpn,spain-tcp.ovpn,spain-udp.ovpn,sweden-tcp.ovpn,sweden-udp.ovpn,switzerland-tcp.ovpn,switzerland-udp.ovpn,text.txt,turkey-tcp.ovpn,turkey-udp.ovpn,uae-dubai-tcp.ovpn,uae-dubai-udp.ovpn,uk1-tcp.ovpn,uk1-udp.ovpn,uk2-tcp.ovpn,uk2-udp.ovpn,ukraine-tcp.ovpn,ukraine-udp.ovpn,uk-stream-tcp.ovpn,uk-stream-udp.ovpn,usa-ashburn-tcp.ovpn,usa-ashburn-udp.ovpn,usa-atlanta-tcp.ovpn,usa-atlanta-udp.ovpn,usa-chicago-tcp.ovpn,usa-chicago-udp.ovpn,usa-colorado-tcp.ovpn,usa-colorado-udp.ovpn,usa-dallas-tcp.ovpn,usa-dallas-udp.ovpn,usa-losangeles-tcp.ovpn,usa-losangeles-udp.ovpn,usa-miami-tcp.ovpn,usa-miami-udp.ovpn,usa-newyork-tcp.ovpn,usa-newyork-udp.ovpn,usa-seattle-tcp.ovpn,usa-seattle-udp.ovpn,usa-stream-tcp.ovpn,usa-stream-udp.ovpn,usa-washington1-tcp.ovpn,usa-washington1-udp.ovpn,usa-washington2-tcp.ovpn,usa-washington2-udp.ovpn
-e OPENVPN_OPTS=--inactive\ 3600\ --ping\ 10\ --ping-exit\ 60
-e LOCAL_NETWORK=192.168.1.0/24
--dns=1.1.1.1 --dns=1.0.0.1 \ -p 9091:9091
-p 51413:51413
-p 51413:51413/udp
-it simplelnx/fastestvpn
```

Docker-Compose 2.1 -

```bash
vpn: 
    cap_add: 
      - NET_ADMIN
    container_name: vpn
    dns: 
      - "8.8.8.8"
      - "4.4.4.4"
    environment: 
      - OPENVPN_USERNAME=<your-user-name>
      - OPENVPN_PASSWORD=<your-password>
      - "OPENVPN_CONFIG=australia1-tcp.ovpn,australia1-udp.ovpn,australia2-tcp.ovpn,australia2-udp.ovpn,austria-tcp.ovpn,austria-udp.ovpn,belgium1-tcp.ovpn,belgium1-udp.ovpn,brazil-tcp.ovpn,brazil-udp.ovpn,bulgaria-tcp.ovpn,bulgaria-udp.ovpn,canada1-tcp.ovpn,canada1-udp.ovpn,canada-stream-tcp.ovpn,canada-stream-udp.ovpn,colombia-tcp.ovpn,colombia-udp.ovpn,czechia-tcp.ovpn,czechia-udp.ovpn,denmark-tcp.ovpn,denmark-udp.ovpn,finland1-tcp.ovpn,finland1-udp.ovpn,finland2-tcp.ovpn,finland2-udp.ovpn,france-tcp.ovpn,france-udp.ovpn,germany1-tcp.ovpn,germany1-udp.ovpn,germany-dus1-tcp.ovpn,germany-dus1-udp.ovpn,germany-dus2-tcp.ovpn,germany-dus2-udp.ovpn,greece-tcp.ovpn,greece-udp.ovpn,hongkong-tcp.ovpn,hongkong-udp.ovpn,hungary-tcp.ovpn,hungary-udp.ovpn,india1-tcp.ovpn,india1-udp.ovpn,india-stream-tcp.ovpn,india-stream-udp.ovpn,ireland-tcp.ovpn,ireland-udp.ovpn,italy1-tcp.ovpn,italy1-udp.ovpn,italy-stream-tcp.ovpn,italy-stream-udp.ovpn,japan1-tcp.ovpn,japan1-udp.ovpn,japan2-tcp.ovpn,japan2-udp.ovpn,japan-stream-tcp.ovpn,japan-stream-udp.ovpn,luxembourg-tcp.ovpn,luxembourg-udp.ovpn,malaysia-tcp.ovpn,malaysia-udp.ovpn,mexico-tcp.ovpn,mexico-udp.ovpn,netherlands1-tcp.ovpn,netherlands1-udp.ovpn,netherlands2-tcp.ovpn,netherlands2-udp.ovpn,norway-tcp.ovpn,norway-udp.ovpn,poland-tcp.ovpn,poland-udp.ovpn,portugal-tcp.ovpn,portugal-udp.ovpn,romania-tcp.ovpn,romania-udp.ovpn,russia-tcp.ovpn,russia-udp.ovpn,serbia-tcp.ovpn,serbia-udp.ovpn,singapore-tcp.ovpn,singapore-udp.ovpn,slovakia-tcp.ovpn,slovakia-udp.ovpn,southafrica-tcp.ovpn,southafrica-udp.ovpn,southkorea1-tcp.ovpn,southkorea1-udp.ovpn,southkorea-stream-tcp.ovpn,southkorea-stream-udp.ovpn,spain-tcp.ovpn,spain-udp.ovpn,sweden-tcp.ovpn,sweden-udp.ovpn,switzerland-tcp.ovpn,switzerland-udp.ovpn,text.txt,turkey-tcp.ovpn,turkey-udp.ovpn,uae-dubai-tcp.ovpn,uae-dubai-udp.ovpn,uk1-tcp.ovpn,uk1-udp.ovpn,uk2-tcp.ovpn,uk2-udp.ovpn,ukraine-tcp.ovpn,ukraine-udp.ovpn,uk-stream-tcp.ovpn,uk-stream-udp.ovpn,usa-ashburn-tcp.ovpn,usa-ashburn-udp.ovpn,usa-atlanta-tcp.ovpn,usa-atlanta-udp.ovpn,usa-chicago-tcp.ovpn,usa-chicago-udp.ovpn,usa-colorado-tcp.ovpn,usa-colorado-udp.ovpn,usa-dallas-tcp.ovpn,usa-dallas-udp.ovpn,usa-losangeles-tcp.ovpn,usa-losangeles-udp.ovpn,usa-miami-tcp.ovpn,usa-miami-udp.ovpn,usa-newyork-tcp.ovpn,usa-newyork-udp.ovpn,usa-seattle-tcp.ovpn,usa-seattle-udp.ovpn,usa-stream-tcp.ovpn,usa-stream-udp.ovpn,usa-washington1-tcp.ovpn,usa-washington1-udp.ovpn,usa-washington2-tcp.ovpn,usa-washington2-udp.ovpn"
      - "OPENVPN_OPTS=--inactive 3600 --ping 10 --ping-exit 60"
      - LOCAL_NETWORK=192.168.1.0/24
    image: simplelnx/fastestvpn
    ports: 
      - "9091:9091"
      - "9117:9117"
      - "51413:51413"
      - "9696:9696"
      - "51413:51413/udp"
    restart: unless-stopped
    volumes: 
      - "/etc/localtime:/etc/localtime:ro"
version: "2.1"
```

Once created, setup transmission using any existing containers. example below.

```
docker run -d
--name=transmission
--net container:vpn
-e PUID=1000
-e PGID=1000
-e TZ=America/New_York
-v your/path:/config
-v your/path:/downloads
-v your/path:/watch
--restart unless-stopped
linuxserver/transmission
```

Transmission docker-compose
```
  transmission:
    container_name: transmission
    depends_on:
      vpn:
        condition: service_healthy
    environment:
      - TZ=America/New_York
      - PUID=1000
      - PGID=1000
    image: linuxserver/transmission
    network_mode: "service:vpn"
    restart: unless-stopped
    volumes:
      - "`your/path`:/config"
      - "`your/path`:/watch"
      - "`your/path`:/downloads"
```

This is setup for using Transmission. If you are using other torrent clients, download the code from Github and build after adding the ports used by the client in expose. Remember to add them while creating the docker container.

#Additional check if needed:
If you want to have an additional check, add this to a script on hour host and schedule cron to run every X minutes.
This will help restart service if down or if vpn is somehow disconnected.
Added sample file in repo


```
*/1 * * * * bash ~/scripts/vpncheck.sh
```

#Docker run
```
#!/bin/bash

localip=`curl ifconfig.me`
vpnip=`docker exec vpn curl ifconfig.me`
if [ "${localip}" = "${vpnip}" ]; then vpncheck1=1;else vpncheck1=0;fi

vpncheck2=`docker ps|grep fastestvpn|grep unhealthy|wc -l`

failed_count=`expr $vpncheck1 + $vpncheck2`

if [ $failed_count -gt 0 ]
then
  docker restart vpn transmission
fi
```

#Docker compose
```
#!/bin/bash

localip=`curl ifconfig.me`
vpnip=`docker exec vpn curl ifconfig.me`
if [ "${localip}" = "${vpnip}" ]; then vpncheck1=1;else vpncheck1=0;fi

vpncheck2=`docker ps|grep fastestvpn|grep unhealthy|wc -l`

failed_count=`expr $vpncheck1 + $vpncheck2`

if [ $failed_count -gt 0 ]
then
  cd #~your_docker_compose_dir~#
  docker compose down
  sleep 2
  docker compose up -d
fi
```
