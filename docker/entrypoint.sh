#!/bin/bash
cd /home/container

npm config set prefix /omegga

# Removing quotes from the config file.
CONFIG_FILE='/home/container/omegga-config.yml'
W_HTTPS=$(yq '.omegga.https' $CONFIG_FILE)
W_WEBUI=$(yq '.omegga.webui' $CONFIG_FILE)
W_DEBUG=$(yq '.omegga.debug' $CONFIG_FILE)

yq -i ".omegga.https=${W_HTTPS}" $CONFIG_FILE
yq -i ".omegga.webui=${W_WEBUI}" $CONFIG_FILE
yq -i ".omegga.debug=${W_DEBUG}" $CONFIG_FILE

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Print Node.js Version
node -v

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
