#!/bin/bash

RUNTIME=`date '+%Y-%m-%d %H:%M'`
RUNDATE=`date '+%Y%m%d'`

script_dir=~/scripts
log_dir=$script_dir/logs
script_log=$log_dir/vpncheck_$RUNDATE.log
Email_log=$log_dir/vpn_email.check

if [ -f /tmp/vpn.lock ];then echo "${RUNTIME}: Script already running. Exiting." >> $script_log;exit 0; else echo "continue script";touch /tmp/vpn.lock; fi

tautulli=`nc -z 192.168.1.110 9091; echo $?`
prowlarr=`nc -z 192.168.1.110 9696; echo $?`

localip=`curl ifconfig.me`
vpnip=`docker exec vpn curl ifconfig.me`
if [ "${localip}" = "${vpnip}" ]; then vpncheck1=1;else vpncheck1=0;fi

vpncheck2=`docker ps|grep fastestvpn|grep unhealthy|wc -l`

failed_count=`expr $tautulli + $prowlarr + $vpncheck1 + $vpncheck2`

if [ $failed_count -gt 0 ]
then
  echo "Vpn services down. Restarting" >> $script_log
  
  cd ~/scripts/scripts_docker/vpn
  docker compose down
  sleep 2
  docker compose up -d

  return_cd=$?

  RUNTIME=`date '+%Y-%m-%d %H:%M'`

  if [ $return_cd -eq 0 ]
  then
	   RUNTIME=`date '+%Y-%m-%d %H:%M'`
	   echo "${RUNTIME}: docker container $1 restarted successfully" >> $script_log
  else
	   RUNTIME=`date '+%Y-%m-%d %H:%M'`
	   echo "${RUNTIME}: docker container $1 restart failed with ${return_cd}" >> $script_log
           #find $Email_log -mmin +180 -exec docker run -i -e SMTP_HOST="smtp.gmail.com:587" -e SMTP_USER=youremail -e SMTP_PASS="yourpass" -e TO="youremail" -e FROM_EMAIL="youremail" -e FROM_NAME="yourname" -e SUBJECT="Vpn restart failed" -e MESSAGE="Vpn restart failed" --rm itsziget/ssmtp-mailer \;
           #find $Email_log -mmin +180 -exec touch $Email_log \;
	   exit 1
  fi

  #find $Email_log -mmin +180 -exec docker run -i -e SMTP_HOST="smtp.gmail.com:587" -e SMTP_USER=youremail -e SMTP_PASS="yourpass" -e TO="youremail" -e FROM_EMAIL="youremail" -e FROM_NAME="yourname" -e SUBJECT="Docker VPN Services failed" -e MESSAGE="VPN services failed and were restarted." --rm itsziget/ssmtp-mailer \;
  #find $Email_log -mmin +180 -exec touch $Email_log \;

else
  echo "all good"
fi

RUNTIME=`date '+%Y-%m-%d %H:%M'`
#echo "${RUNTIME}: vpn check script ran successfully" >> $script_log
rm /tmp/vpn.lock

exit 0

