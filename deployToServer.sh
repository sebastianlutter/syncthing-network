#!/bin/bash
#
# Make sure the SRV variable contains the right server URL, then use this
# script to deploy/update the gateway stack on the server. Also take a look
# into the README.md file.
#
SRV="${SSH_SERVER}"

function exitIfErr() {
  if [ $1 -ne 0 ]; then
    echo "$2"
    exit 1
  fi
}

# make sure the remote folder exists
ssh ${SRV} "[ ! -d syncthing-network ] && mkdir syncthing-network"
# copy needed files to the remote server
scp  env.sh docker-compose.yaml deployStack.sh ${SRV}:syncthing-network/
exitIfErr $? "Failed to copy files to ${SRC}:/syncthing-network"
# deploy gateway stack
ssh ${SRV} "cd syncthing-network && ./deployStack.sh;"
