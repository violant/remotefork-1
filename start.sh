#!/bin/bash

/opt/acestream.engine/start-engine --client-console @/opt/acestream.engine/acestream.conf >/dev/null 2>&1 &

cd /opt/linux-x64/
chmod +x RemoteForkCP
./RemoteForkCP $1 >/dev/null 2>&1 &

while true; do
        sleep 1200
        rm -rf /tmp/.ACEStream/collected_torrent_files/*
done
