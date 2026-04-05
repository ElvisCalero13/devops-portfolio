$ErrorActionPreference = "Stop"

$API_IMAGE_NAME="project-2-api"
$WORKER_IMAGE_NAME="project-2-worker"
$IMAGE_TAG="latest"

Write-Host "Building API image..."
docker build -t "${API_IMAGE_NAME}:${IMAGE_TAG}" -f docker/Dockerfile.api .

Write-Host "Building Worker image..."
docker build -t "${WORKER_IMAGE_NAME}:${IMAGE_TAG}" -f docker/Dockerfile.worker .

Write-Host "Done."
Write-Host "Built images:"
Write-Host " - ${API_IMAGE_NAME}:${IMAGE_TAG}"
Write-Host " - ${WORKER_IMAGE_NAME}:${IMAGE_TAG}"