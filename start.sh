#!/bin/bash

echo "started script"

ping -c1 google.com
STATUS=$?
if [ ${STATUS} -ne 0 ]
then
    echo "Network is down"
else
    echo "Network good"
fi


mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 0666 /dev/net/tun


if [[ -n "${OPENVPN_CONFIG-}" ]]; then
readarray -t OPENVPN_CONFIG_ARRAY <<< "${OPENVPN_CONFIG//,/$'\n'}"

## Trim leading and trailing spaces from all entries. Inefficient as all heck, but works like a champ.
for i in "${!OPENVPN_CONFIG_ARRAY[@]}"; do
  OPENVPN_CONFIG_ARRAY[${i}]="${OPENVPN_CONFIG_ARRAY[${i}]#"${OPENVPN_CONFIG_ARRAY[${i}]%%[![:space:]]*}"}"
  OPENVPN_CONFIG_ARRAY[${i}]="${OPENVPN_CONFIG_ARRAY[${i}]%"${OPENVPN_CONFIG_ARRAY[${i}]##*[![:space:]]}"}"
done

# If there were multiple configs (comma separated), select one of them
if (( ${#OPENVPN_CONFIG_ARRAY[@]} > 1 )); then
  OPENVPN_CONFIG_RANDOM=$((RANDOM%${#OPENVPN_CONFIG_ARRAY[@]}))
  echo "${#OPENVPN_CONFIG_ARRAY[@]} servers found in OPENVPN_CONFIG, ${OPENVPN_CONFIG_ARRAY[${OPENVPN_CONFIG_RANDOM}]} chosen randomly"
  OPENVPN_CONFIG="${OPENVPN_CONFIG_ARRAY[${OPENVPN_CONFIG_RANDOM}]}"
fi

VPN_PROVIDER_HOME="/config/fastestvpn"


# Check that the chosen config exists.
if [[ -f "${VPN_PROVIDER_HOME}/${OPENVPN_CONFIG}.ovpn" ]]; then
  echo "Starting OpenVPN using config ${OPENVPN_CONFIG}.ovpn"
  CHOSEN_OPENVPN_CONFIG="${VPN_PROVIDER_HOME}/${OPENVPN_CONFIG}.ovpn"
else
  echo "Supplied config ${OPENVPN_CONFIG}.ovpn could not be found."
  echo "Your options for this provider are:"
  ls "${VPN_PROVIDER_HOME}" | grep .ovpn
  echo "NB: Remember to not specify .ovpn as part of the config name."
  exit 1 # No longer fall back to default. The user chose a specific config - we should use it or fail.
fi
else
echo "No VPN configuration provided. Using default."
CHOSEN_OPENVPN_CONFIG="${VPN_PROVIDER_HOME}/default.ovpn"
fi


echo $OPENVPN_USERNAME > /auth.txt
echo $OPENVPN_PASSWORD >> /auth.txt
chmod 600 /auth.txt


if [[ -z "$LOCAL_NETWORK" ]]
then
  echo "LOCAL_NETWORK not set. Use reverse proxy for access"
else
  eval $(/sbin/ip route list match 0.0.0.0 | awk '{if($5!="tun0"){print "GW="$3"\nINT="$5; exit}}')
  echo "allowing traffic using command /sbin/ip route add ${LOCAL_NETWORK} via ${GW} dev ${INT}"
  /sbin/ip route add "${LOCAL_NETWORK}" via "${GW}" dev "${INT}"
fi

echo "starting openvpn as exec openvpn ${OPENVPN_OPTS} --config "${CHOSEN_OPENVPN_CONFIG}""

#exec openvpn --config /config/fastestvpn/France-UDP.ovpn
exec openvpn ${OPENVPN_OPTS} --config "${CHOSEN_OPENVPN_CONFIG}"
