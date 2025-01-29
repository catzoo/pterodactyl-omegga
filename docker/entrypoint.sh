#!/bin/bash
cd /home/container

# Sets up the auth file with omegga if user.txt exists
# For some reason omegga doesn't exit if you set -u and -p.
# So request the user to kill the server and restart it.
if [ -e user.txt ]
then
	echo "Found user.txt. Generating auth. After complete, please restart the server."
	USER=$(sed '1q;d' user.txt)
	PASS=$(sed '2q;d' user.txt)
	rm user.txt
	omegga auth -gl
	omegga auth -u ${USER} -p ${PASS}
fi

# Removing quotes from the config file.
CONFIG_FILE='/home/container/omegga-config.yml'
W_HTTPS=$(yq '.omegga.https' $CONFIG_FILE)
W_WEBUI=$(yq '.omegga.webui' $CONFIG_FILE)

yq -i ".omegga.https=${W_HTTPS}" $CONFIG_FILE
yq -i ".omegga.webui=${W_WEBUI}" $CONFIG_FILE


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
