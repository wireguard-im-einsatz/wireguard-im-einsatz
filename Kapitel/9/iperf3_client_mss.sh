#!/bin/bash

PEER=10.6.3.1   # tunnel peer
RUNTIME=60

for MTU in 1500 1420 1280 1024 512 256 128 ; do
  echo "*** Benchmarking with MTU ${MTU} Bytes"
  sleep 1
  iperf3 --client ${PEER} --time ${RUNTIME} --interval ${RUNTIME} \
    --set-mss $(($MTU-110)) --format m | grep bit | head -1
done
