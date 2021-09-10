FROM ghcr.io/petermetz/dci-lint:0.4.0

USER root
RUN apt update && apt install -y jq
USER ${APP_USER}

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /usr/src/app/

# Executes `docker-entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/docker-entrypoint.sh"]
