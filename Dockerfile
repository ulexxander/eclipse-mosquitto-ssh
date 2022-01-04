FROM eclipse-mosquitto
COPY docker-entrypoint.sh docker-entrypoint-extended.sh
ARG SSH_USERNAME=admin
ARG SSH_PASSWORD=admin
RUN \
  echo -e "$SSH_USERNAME\n$SSH_PASSWORD\n" | adduser admin && \
  apk add --no-cache openssh && \
  chmod +x docker-entrypoint-extended.sh
EXPOSE 22
ENTRYPOINT ["/docker-entrypoint-extended.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
