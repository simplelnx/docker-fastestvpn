#!/bin/bash

#Network check
# Ping uses both exit codes 1 and 2. Exit code 2 cannot be used for docker health checks,
# therefore we use this script to catch error code 2
HOST=${HEALTH_CHECK_HOST}

if [[ -z "$HOST" ]]
then
    HOST="google.com"
fi

ping -c 2 -w 10 $HOST # Get at least 2 responses and timeout after 10 seconds
STATUS=$?
if [[ ${STATUS} -ne 0 ]]
then
    echo "Network is down"
    exit 1
fi

echo "Network is up"

#Service check
#Expected output is 2 for both checks, 1 for process and 1 for grep
OPENVPN=$(pgrep openvpn | wc -l )

if [[ ${OPENVPN} -ne 1 ]]; then
	echo "Openvpn process not running"
	exit 1
fi

echo "Openvpn processe are running"
exit 0
