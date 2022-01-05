FROM eclipse-mosquitto
COPY docker-entrypoint.sh docker-entrypoint-extended.sh
ARG SSH_USERNAME=admin
ARG SSH_PASSWORD=admin
RUN \
  apk add --no-cache openssh && \
  # add user for SSH that belongs to mosquitto group
  echo -e "$SSH_PASSWORD\n$SSH_PASSWORD\n" | adduser $SSH_USERNAME -G mosquitto && \
  # initial permissions are 755, add write permission in this directory for mosquitto group
  # userful for initializing plugin config files (dynsec, for example)
  chmod 775 /mosquitto/config && \
  chmod +x docker-entrypoint-extended.sh
EXPOSE 22
ENTRYPOINT ["/docker-entrypoint-extended.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
