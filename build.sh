#!/bin/sh

CONTAINER_IMAGE=${CONTAINER_IMAGE:-nextthingco/chiptainer_spi_accelerometer}

docker build --no-cache=true -t "${CONTAINER_IMAGE}" .
