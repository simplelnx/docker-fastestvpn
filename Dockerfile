FROM ubuntu:18.05

ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo $TZ > /etc/timezone \
    && apt update \ 
    && apt install -y openvpn iputils-ping \
    && rm -rf /var/lib/apt/lists/*

#RUN apt update \
#    && apt install -y wget tar \
#    && rm -rf /var/lib/apt/lists/*

#RUN cd / && wget https://github.com/Jackett/Jackett/releases/download/v0.17.627/Jackett.Binaries.LinuxARM32.tar.gz

#RUN mv /Jackett.Binaries.LinuxARM32.tar.gz Jackett.gz

#RUN tar -xf /Jackett.gz && echo "unzip done"

#RUN ./Jackett/install_service_systemd.sh

#RUN rm /Jackett.gz


# Add configuration and scripts
#ADD openvpn/ /etc/openvpn/
#ADD transmission/ /etc/transmission/
#ADD tinyproxy /opt/tinyproxy/
#ADD scripts /etc/scripts/

#ENV TRANSMISSION_HOME=/data/transmission-home \
#    TRANSMISSION_RPC_PORT=9091 \
#    TRANSMISSION_DOWNLOAD_DIR=/data/completed \
#    TRANSMISSION_INCOMPLETE_DIR=/data/incomplete \
#    TRANSMISSION_WATCH_DIR=/data/watch \
#    HEALTH_CHECK_HOST=google.com

EXPOSE 9091
EXPOSE 9117
EXPOSE 51413
EXPOSE 51413/udp
EXPOSE 9696


ADD start.sh /start.sh

RUN chmod +x /start.sh
RUN mkdir /config
RUN mkdir /config/fastestvpn

ADD healthcheck.sh /healthcheck.sh

RUN chmod +x /healthcheck.sh

ADD fastestvpn/ /config/fastestvpn/

HEALTHCHECK --interval=1m CMD /healthcheck.sh


CMD ["./start.sh"]
