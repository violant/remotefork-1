#!/bin/bash

/opt/acestream.engine/start-engine --client-console --cache-dir /tmp/.ACEStream --state-dir /tmp/.ACEStream --live-cache-type memory --vod-cache-type memory --live-buffer 25 --vod-buffer 10 --vod-drop-max-age 120 >/dev/null 2>&1 &

cd /opt/linux-x64/
chmod +x RemoteForkCP
./RemoteForkCP $1 >/dev/null 2>&1 &

while true; do
        sleep 1200
        rm -rf /tmp/.ACEStream/collected_torrent_files/*
done
