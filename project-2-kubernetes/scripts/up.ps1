$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "Step 1: Build Docker images..."
& (Join-Path $scriptDir "build-images.ps1")

Write-Host "Step 2: Create kind cluster..."
& (Join-Path $scriptDir "create-kind-cluster.ps1")

Write-Host "Step 3: Load images into kind..."
& (Join-Path $scriptDir "load-images.ps1")

Write-Host "Step 4: Deploy Kubernetes resources..."
& (Join-Path $scriptDir "deploy.ps1")

Write-Host ""
Write-Host "Done."
Write-Host "Check resources with:"
Write-Host "  kubectl get pods -n project-2"
Write-Host "  kubectl get ingress -n project-2"
Write-Host "  kubectl get hpa -n project-2"