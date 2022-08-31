# docker-fastestvpn
docker image for fastestvpn provider


Simple docker image for fastestvpn.com provider. Used for linking transmission and other containers.

This is inspired by https://hub.docker.com/r/haugene/transmission-openvpn

Documentation for variables below can be found in the link below. https://haugene.github.io/docker-transmission-openvpn/

docker run --name vpn --cap-add=NET_ADMIN -d
--restart unless-stopped
-v /etc/localtime:/etc/localtime:ro
-e OPENVPN_USERNAME=username
-e OPENVPN_PASSWORD=password
-e OPENVPN_CONFIG=australia1-tcp,australia1-udp,australia2-tcp,australia2-udp,austria-tcp,austria-udp,belgium1-tcp,belgium1-udp,belgium2-tcp,belgium2-udp,brazil2-tcp,brazil2-udp,brazil3-tcp,brazil3-udp,bulgaria-tcp,bulgaria-udp,canada1-tcp,canada1-udp,canada2-tcp,canada2-udp,canada-stream-tcp,canada-stream-udp,czechia-tcp,czechia-udp,denmark-tcp,denmark-udp,finland-tcp,finland-udp,france-tcp,france-udp,germany1-tcp,germany1-udp,germany-dus1-tcp,germany-dus1-udp,germany-dus2-tcp,germany-dus2-udp,hongkong1-tcp,hongkong1-udp,hongkong3-tcp,hongkong3-udp,india2-tcp,india2-udp,india3-tcp,india3-udp,india-stream1-tcp,india-stream1-udp,india-stream2-tcp,india-stream2-udp,india-stream3-tcp,india-stream3-udp,india-stream4-tcp,india-stream4-udp,italy-stream-tcp,italy-stream-udp,italy-tcp,italy-udp,japan1-tcp,japan1-udp,japan2-tcp,japan2-udp,japan-stream-tcp,japan-stream-udp,luxembourg-tcp,luxembourg-udp,malaysia-tcp,malaysia-udp,mexico-tcp,mexico-udp,netherlands1-tcp,netherlands1-udp,netherlands2-tcp,netherlands2-udp,netherlands3-tcp,netherlands3-udp,norway-tcp,norway-udp,poland-tcp,poland-udp,portugal-tcp,portugal-udp,romania-tcp,romania-udp,russia1-tcp,russia1-udp,russia2-tcp,russia2-udp,serbia1-tcp,serbia1-udp,serbia2-tcp,serbia2-udp,singapore-tcp,singapore-udp,southkorea-tcp,southkorea-udp,spain-tcp,spain-udp,sweden1-tcp,sweden1-udp,sweden2-tcp,sweden2-udp,switzerland-tcp,switzerland-udp,turkey-tcp,turkey-udp,uae-dubai-tcp,uae-dubai-udp,uk1-tcp,uk1-udp,uk2-tcp,uk2-udp,uk3-tcp,uk3-udp,uk-stream-tcp,uk-stream-udp,usa-atlanta-tcp,usa-atlanta-udp,usa-charlotte-tcp,usa-charlotte-udp,usa-chicago1-tcp,usa-chicago1-udp,usa-chicago2-tcp,usa-chicago2-udp,usa-dallas-tcp,usa-dallas-udp,usa-denver-tcp,usa-denver-udp,usa-losangeles1-tcp,usa-losangeles1-udp,usa-losangeles2-tcp,usa-losangeles2-udp,usa-miami-tcp,usa-miami-udp,usa-newyork-tcp,usa-newyork-udp,usa-phoenix1-tcp,usa-phoenix1-udp,usa-phoenix2-tcp,usa-phoenix2-udp,usa-seattle-tcp,usa-seattle-udp,usa-st.louis1-tcp,usa-st.louis1-udp,usa-st.louis2-tcp,usa-st.louis2-udp,usa-st.louis3-tcp,usa-st.louis3-udp,usa-stream-tcp,usa-stream-udp,usa-washington1-tcp,usa-washington1-udp,usa-washington2-tcp,usa-washington2-udp
-e OPENVPN_OPTS=--inactive\ 3600\ --ping\ 10\ --ping-exit\ 60
-e LOCAL_NETWORK=192.168.1.0/24
--dns=1.1.1.1 --dns=1.0.0.1 \ -p 9091:9091
-p 51413:51413
-p 51413:51413/udp
-it simplelnx/fastestvpn

Docker-Compose 2.1 -

vpn: cap_add: - NET_ADMIN container_name: vpn dns: - "8.8.8.8" - "4.4.4.4" environment: - OPENVPN_USERNAME=

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

This is setup for using Transmission. If you are using other torrent clients, download the code from Github and build after adding the ports used by the client in expose. Remember to add them while creating the docker container.
