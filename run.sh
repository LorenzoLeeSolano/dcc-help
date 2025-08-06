#!/usr/bin/env sh

# Build and attach to the docker image.
docker compose build
docker compose up dcc-help -d
exec docker compose exec dcc-help bash