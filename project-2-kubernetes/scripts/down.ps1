$ErrorActionPreference = "Stop"

Write-Host "Deleting kind cluster..."
kind delete cluster --name project-2

Write-Host "Done."