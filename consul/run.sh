#!/bin/bash
set -e

j2 -o config.hcl config.hcl.j2
consul agent -config-file config.hcl &

if [ ${DISCONNECT} == "true" ]
then
  echo "Sleeping for 60 seconds to allow cluster to stabilize before disconnecting node..."
  sleep 60

  echo "Disconnecting node..."
  ip route save > routes
  ip route flush all

  echo "Sleeping for 60 seconds to allow cluster to diverge before reconnecting node..."
  sleep 60

  echo "Reconnecting node..."
  ip route restore < routes
fi

sleep infinity
