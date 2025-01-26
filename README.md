# Omegga Egg
This is a [Pterodactyl](https://pterodactyl.io/) egg of the Brickadia [Omegga](https://github.com/brickadia-community/omegga) server. 

This repository contains the dockerfile and the exported egg for Pterodactyl. The dockerfile use the base image: [Node20 yolk](https://github.com/pelican-eggs/yolks?tab=readme-ov-file#nodejs). It installs more dependencies for Brickadia and modifies the `entrypoint.sh` file.

### Ports
- Game Server Port: 7777
- WebUI Port: 8081

## Building
This egg requires the docker image to run. I recommend building the image on the Pterodactyl Wings server with the tag `brickadia:latest`. You can use a different tag but you will have to update the egg settings.

You then can import the egg from the `egg/egg-brickadia--omegga.json` file.

## Running
After you create the server and Pterodactyl installs it. Create a `user.txt` file in the root `/home/container` directory. Add your Brickadia username and password in this format:

```
username
password
```

When you run the server. It will regenerate the auth file and login as the user. Then automatically deletes the `user.txt` file.

The reason why it's done in this way is because Pterodactyl logs every command. So, if you type in the username / password in the console, Pterodactyl will log it in plain text. But if you create a file, all Pterodactyl will log is the user creating a `user.txt` file.
