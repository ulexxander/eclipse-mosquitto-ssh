#!/bin/ash

echo "Generating host SSH keys"
ssh-keygen -A

echo "Starting SSH daemon in background"
/usr/sbin/sshd -D &

echo "Executing original eclipse-mosquitto docker-entrypoint.sh"
./docker-entrypoint.sh "$@"
