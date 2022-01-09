#!/bin/ash

if [ -n "$SSH_USERNAME" ] && [ -n "$SSH_PASSWORD" ]; then
  if ! id -u "$SSH_USERNAME" > /dev/null 2>&1; then
    echo "Adding SSH user"
    echo -e "$SSH_PASSWORD\n$SSH_PASSWORD\n" | adduser $SSH_USERNAME
  fi
fi


if [ -n "$DYNSEC_USERNAME" ] && [ -n "$DYNSEC_PASSWORD" ] && [ -n "$DYNSEC_CONFIG_FILE" ]; then
  if [ ! -f "$DYNSEC_CONFIG_FILE" ]; then
    echo "Initializing dynsec"
    echo -e "$DYNSEC_PASSWORD\n$DYNSEC_PASSWORD\n" | mosquitto_ctrl dynsec init $DYNSEC_CONFIG_FILE $DYNSEC_USERNAME
  fi
fi

echo "Generating host SSH keys"
ssh-keygen -A

echo "Starting SSH daemon in background"
/usr/sbin/sshd -D &

echo "Executing original eclipse-mosquitto entrypoint"
./docker-entrypoint.sh "$@"
