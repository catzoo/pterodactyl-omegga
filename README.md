# Omegga Egg
This is a [Pterodactyl](https://pterodactyl.io/) egg of the Brickadia [Omegga](https://github.com/brickadia-community/omegga) server. 

This repository contains the dockerfile and the exported egg for Pterodactyl. The dockerfile use the base image: [Node20 yolk](https://github.com/pelican-eggs/yolks?tab=readme-ov-file#nodejs). It installs more dependencies for Omegga and modifies the `entrypoint.sh` file.

### Ports
- Game Server Port: 7777
- WebUI Port: 8080

## Running
Import the egg from `egg/egg-brickadia--omegga.json`. Then install and run the server.