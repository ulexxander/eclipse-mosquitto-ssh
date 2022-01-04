CONTAINER_NAME=test-eclipse-mosquitto-ssh
SSH_USERNAME=admin
SSH_PASSWORD=admin
SSH_PORT=1882

test-build() {
  docker build -t eclipse-mosquitto-ssh .
}

test-up() {
  echo "Running container $CONTAINER_NAME"
  docker run \
    --name $CONTAINER_NAME \
    -p $SSH_PORT:22 -d \
    -v $PWD/test.mosquitto.conf:/mosquitto/config/mosquitto.conf \
    eclipse-mosquitto-ssh
}

test-ssh() {
  echo "Removing test host from ~/.ssh/known_hosts"
  sed -i "/\[localhost\]:$SSH_PORT/d" ~/.ssh/known_hosts
  ssh $SSH_USERNAME@localhost -p $SSH_PORT
}

test-down() {
  echo "Killing container $CONTAINER_NAME"
  docker container kill $CONTAINER_NAME

  echo "Removing container $CONTAINER_NAME"
  docker container rm $CONTAINER_NAME
}

test-logs() {
  docker logs $CONTAINER_NAME
}

test-shell() {
  docker exec -it $CONTAINER_NAME sh
}
