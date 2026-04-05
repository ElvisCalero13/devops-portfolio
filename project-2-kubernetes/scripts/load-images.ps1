$ErrorActionPreference = "Stop"

Write-Host "Loading Docker images into kind..."
kind load docker-image project-2-api:latest --name project-2
kind load docker-image project-2-worker:latest --name project-2

Write-Host "Images loaded successfully."