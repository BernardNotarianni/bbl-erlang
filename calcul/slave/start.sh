#!/usr/bin/env bash

echo "Slave starting"
echo "--------------"

SNAME=${1:-"slave1@127.0.0.1"}

erl -pa ebin -name $SNAME -setcookie demo_app -eval "application:start(calcul_slave)"
