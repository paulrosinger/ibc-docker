#!/usr/bin/env bash
mkdir -p tmp_jts
docker rm ibc
docker run --name ibc -e DISPLAY=$IP:0 -v $(pwd)/tmp_jts:/persist  -e TWSUSERID=${TWSUSERID} -e TWSPASSWORD=${TWSPASSWORD} -e TRADING_MODE=${TRADING_MODE} -e initmode=true -p 4001:4001 ibc
