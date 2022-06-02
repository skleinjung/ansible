#!/usr/bin/env bash
export WINEARCH=win64
/usr/bin/xvfb-run \
  --auto-servernum \
  --server-args='-screen 0 640x480x24:32' \
  /usr/bin/wine \
    VRisingServer.exe \
    -persistentDataPath server1_saves/ \
    -logFile server.log