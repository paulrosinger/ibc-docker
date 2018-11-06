#!/usr/bin/env bash

docker rm ibc
docker run --name ibc -v $(pwd)/tmp_jts:/persist  -e TWSUSERID=${TWSUSERID} -e TWSPASSWORD=${TWSPASSWORD} -e TRADING_MODE=${TRADING_MODE} -p 4001:4001 ibc
