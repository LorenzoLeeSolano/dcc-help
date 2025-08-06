#!/usr/bin/env sh

# Build and attach to the docker image.
docker compose build
docker compose up dcc-help-demo -d
echo "Connecting to container. May need to wait for model to download."
exec docker compose exec dcc-help-demo bash