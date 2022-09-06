#!/bin/bash
set -e

j2 -o config.hcl config.hcl.j2
vault server -config config.hcl &

export VAULT_ADDR=http://${HOSTNAME}:8200

if [ ${INIT} == "true" ]
then
  until vault operator init -n 1 -t 1 -format json > .vault-init.json; do :; done
  jq -r .root_token .vault-init.json > .vault-token
  jq -r .unseal_keys_b64[0] .vault-init.json > .vault-unseal

  until vault operator unseal $(< .vault-unseal); do :; done
  for host in ${JOIN}
  do
    until vault operator unseal -address http://${host}:8200 $(< .vault-unseal); do :; done
  done
else
  sleep 15
fi

if [ ${DISCONNECT} == "true" ]
then
  echo "Sleeping for 30 seconds to allow cluster to stabilize before disconnecting node..."
  sleep 30

  echo "Disconnecting node..."
  ip route save > routes
  ip route flush all

  echo "Sleeping for 60 seconds to allow cluster to diverge before reconnecting node..."
  sleep 60

  echo "Reconnecting node..."
  ip route restore < routes
fi

sleep infinity
