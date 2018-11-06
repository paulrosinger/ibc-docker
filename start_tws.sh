#!/bin/bash
set -Eeuxo pipefail

IBC_INI=$IBC_PATH/config.ini
LOG_PATH=$IBC_PATH/logs

APP=GATEWAY
TWS_CONFIG_PATH="$TWS_PATH"

export TRADING_MODE
export TWSUSERID
export TWSPASSWORD
export TWSPORT

sed -e "s/{ibloginid}/${TWSUSERID}/;s/{ibpassword}/${TWSPASSWORD}/;s/{tradingmode}/${TRADING_MODE}/" config_template.ini > config.ini
cat config.ini
cat config.ini > $IBC_INI

if [[ "$(echo ${APP} | tr '[:lower:]' '[:upper:]')" = "GATEWAY" ]]; then
  gw_flag=-g
fi

IBC_VRSN=$(cat $IBC_PATH/version)
export IBC_VRSN

# a poor man's logrotate
if [ -e "$TWS_PATH/launcher.log" ]
then
  cat $TWS_PATH/launcher.log >> $TWS_PATH/launcher.log.old
  rm $TWS_PATH/launcher.log
fi

socat TCP-LISTEN:4001,fork TCP:127.0.0.1:4002&

if [[ -z "${initmode+x}"  ]]; then
    echo "Running in headless mode. Configuration will be loaded from  /persist/jts.tgz.b64"
    mkdir -p ${TWS_PATH}
    cat /persist/jts.tgz.b64 | base64 --decode > jts.tgz
    tar xf jts.tgz -C ${TWS_PATH}/..


    xvfb-run -a "${IBC_PATH}/scripts/ibcstart.sh" \
      "${TWS_MAJOR_VRSN}" ${gw_flag} \
      "--tws-path=${TWS_PATH}" \
      "--tws-settings-path=${TWS_CONFIG_PATH}" \
      "--ibc-path=${IBC_PATH}" \
      "--ibc-ini=${IBC_INI}"

    exit 0
else
	echo "Running in setup mode. Configuration will be saved to /persist/jts.tgz.b64"

	/bin/bash "${IBC_PATH}/scripts/ibcstart.sh" \
      "${TWS_MAJOR_VRSN}" ${gw_flag} \
      "--tws-path=${TWS_PATH}" \
      "--tws-settings-path=${TWS_CONFIG_PATH}" \
      "--ibc-path=${IBC_PATH}" \
      "--ibc-ini=${IBC_INI}"



    tar czf jts.tgz -C ${TWS_PATH}/.. Jts
    cat jts.tgz | base64 > /persist/jts.tgz.b64

    exit 0
fi
