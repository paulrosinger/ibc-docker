#!/usr/bin/env bash

export TWSUSERID=edemo
export TWSPASSWORD=demouser
export TRADING_MODE=live
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')