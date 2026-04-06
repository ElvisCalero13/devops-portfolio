#!/usr/bin/env bash
set -e

API_IMAGE_NAME=project-2-api
WORKER_IMAGE_NAME=project-2-worker
IMAGE_TAG=latest

echo "Building API image..."
docker build -t ${API_IMAGE_NAME}:${IMAGE_TAG} -f docker/Dockerfile.api .

echo "Building Worker image..."
docker build -t ${WORKER_IMAGE_NAME}:${IMAGE_TAG} -f docker/Dockerfile.worker .

echo "Done."
echo "Built images:"
echo " - ${API_IMAGE_NAME}:${IMAGE_TAG}"
echo " - ${WORKER_IMAGE_NAME}:${IMAGE_TAG}"