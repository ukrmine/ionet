#!/bin/bash

if docker ps | grep -q "io-worker-monitor" && docker ps | grep -q "io-worker-vc"; then
    echo "NODE IS WORKING"
else
    echo "NODE ERROR, RUNING NEW NODE"
    ./launch_binary_linux --device_id= YOURDEVICEID --user_id=YOURUSERID --operating_system="Linux" --usegpus=false --device_name= YOURDEVICENAME
fi
