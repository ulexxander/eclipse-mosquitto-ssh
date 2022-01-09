# Eclipse Mosquitto SSH Docker Image

Extends https://github.com/eclipse/mosquitto Docker image, adds SSH daemon running in the background.

[Docker Hub](https://hub.docker.com/r/ulexxander/eclipse-mosquitto-ssh)

## Features

- Extends https://github.com/eclipse/mosquitto
- Installs `openssh`
- If variables`SSH_USERNAME` and `SSH_PASSWORD` are set - creates user intended to authenticate with SSH
- If variables `DYNSEC_USERNAME`, `DYNSEC_PASSWORD` and `DYNSEC_CONFIG_FILE` are set - initializes [Dynsec Plugin](https://mosquitto.org/documentation/dynamic-security) before starting mosquitto (initializing Dynsec while broker is running will require broker restart for Dynsec to start working)
- Generates host SSH keys and starts SSH daemon in background

## Usage

```sh
# Pull image
docker pull ulexxander/eclipse-mosquitto-ssh:v1.2.0

# Run image with pre-created user for SSH
# Mosquitto config is expected to be located in /mosquitto/config/mosquitto.conf
docker run \
  -e "SSH_USERNAME=admin" -e "SSH_PASSWORD=123" \
  ulexxander/eclipse-mosquitto-ssh:v1.2.0

# Override config path
docker run \
  -e "SSH_USERNAME=admin" -e "SSH_PASSWORD=123" \
  ulexxander/eclipse-mosquitto-ssh:v1.2.0 mosquitto -c /mosquitto-no-auth.conf

# Initialize dynsec on startup as well
# To actually use it do not forget to provide config which enables it
docker run \
  -e "SSH_USERNAME=admin" -e "SSH_PASSWORD=123" \
  -e "DYNSEC_USERNAME=admin" -e "DYNSEC_PASSWORD=123" -e "DYNSEC_CONFIG_FILE=/mosquitto/config/dynamic-security.json" \
  ulexxander/eclipse-mosquitto-ssh:v1.2.0 mosquitto -c /mosquitto-no-auth.conf
```

### Docker Compose example

```yml
version: "3.8"

services:
  mosquitto:
    image: ulexxander/eclipse-mosquitto-ssh:v1.2.0
    ports:
      - "1883:1883"
      - "1882:22"
    volumes:
      - ./mosquitto.conf:/mosquitto/config/mosquitto.conf
    environment:
      - SSH_USERNAME=admin
      - SSH_PASSWORD=123
      - DYNSEC_USERNAME=admin
      - DYNSEC_PASSWORD=123
      - DYNSEC_CONFIG_FILE=/mosquitto/config/dynamic-security.json
```
