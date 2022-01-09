FROM eclipse-mosquitto
RUN apk add --no-cache openssh
COPY docker-entrypoint.sh docker-entrypoint-extended.sh
RUN chmod +x docker-entrypoint-extended.sh
EXPOSE 22
ENTRYPOINT ["/docker-entrypoint-extended.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
