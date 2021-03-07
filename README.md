# docker-fastestvpn
docker image for fastestvpn provider


Simple docker image for fastestvpn.com provider. Used for linking transmission and other containers.

docker run --name vpn --cap-add=NET_ADMIN -d
--restart unless-stopped
-v /etc/localtime:/etc/localtime:ro
-e OPENVPN_USERNAME=username
-e OPENVPN_PASSWORD=password
-e OPENVPN_CONFIG=Australia1-UDP,Australia2-UDP,Austria-UDP,Belgium1-UDP,Belgium2-UDP,Belgium3-UDP,Brazil-UDP,Bulgaria-UDP,Canada-UDP,Czechia-UDP,Finland-UDP,France-UDP,Germany-UDP,Hong.Kong-UDP,India1-UDP,India2-UDP,India3-UDP,India4-UDP,India5-UDP,Italy-UDP,Japan-UDP,Luxembourg-UDP,Netherlands1-UDP,Netherlands2-UDP,Netherlands3-UDP,Norway-UDP,Poland-UDP,Romania-UDP,Russia-UDP,Serbia-UDP,Singapore-UDP,South.Korea-UDP,Spain-UDP,Sweden1-UDP,Sweden2-UDP,Switzerland-UDP,Turkey-UDP,UAE-Dubai-UDP,UK1-UDP
-e OPENVPN_OPTS=--inactive\ 3600\ --ping\ 10\ --ping-exit\ 60
-e LOCAL_NETWORK=192.168.1.0/24
--dns=1.1.1.1 --dns=1.0.0.1 \ -p 9091:9091
-p 51413:51413
-p 51413:51413/udp
-it simplelnx/fastestvpn

Once created, setup transmission using any existing containers. example below.

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
