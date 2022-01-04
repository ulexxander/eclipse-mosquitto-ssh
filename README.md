# Eclipse Mosquitto SSH Docker Image

Extends https://github.com/eclipse/mosquitto Docker image, adds SSH daemon running in the background.

[Docker Hub](https://hub.docker.com/r/ulexxander/eclipse-mosquitto-ssh)

## Features

- Extends https://github.com/eclipse/mosquitto
- Adds user to use with SSH: by default `admin` with password `admin`, but can be overriden with args `SSH_USERNAME` and `SSH_PASSWORD`
- Installs `openssh`
- During startup generates host SSH keys and starts SSH daemon in background

## Usage

```sh
# Pull image
docker pull ulexxander/eclipse-mosquitto-ssh:v1.0.0

# Run image, config is expected to be located in /mosquitto/config/mosquitto.conf
docker run ulexxander/eclipse-mosquitto-ssh:v1.0.0

# Override config path
docker run ulexxander/eclipse-mosquitto-ssh:v1.0.0 mosquitto -c /mosquitto-no-auth.conf
```
