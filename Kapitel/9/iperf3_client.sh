#!/bin/bash

INTERFACE=eth0
PEER=10.6.3.1   # WireGuard tunnel

for MTU in 1420 1280 1024 512 256 128 88 ; do
  echo "*** Benchmarking with MTU ${MTU} Bytes"
  ifconfig ${INTERFACE} mtu ${MTU}
  sleep 2
  iperf3 --client ${PEER} --time 60 --interval 60 --window 128K --format m | grep bit
done

# reset interface MTU
sudo ifconfig ${INTERFACE} down
sudo ifconfig ${INTERFACE} mtu 1500
sudo ifconfig ${INTERFACE} up
