#!/usr/bin/env bash

echo "Master starting"
echo "---------------"

erl -pa ebin -name master@127.0.0.1 -setcookie demo_app -eval "application:start(calcul_master)"
