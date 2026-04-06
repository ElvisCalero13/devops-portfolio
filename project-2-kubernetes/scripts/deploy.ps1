$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$basePath = Join-Path $scriptDir "..\k8s\base"

Write-Host "Applying namespace..."
kubectl apply -f (Join-Path $basePath "namespace.yml")

Write-Host "Deploying Redis..."
kubectl apply -f (Join-Path $basePath "redis-deployment.yml")
kubectl apply -f (Join-Path $basePath "redis-service.yml")

Write-Host "Deploying API..."
kubectl apply -f (Join-Path $basePath "api-deployment.yml")
kubectl apply -f (Join-Path $basePath "api-service.yml")

Write-Host "Deploying Worker..."
kubectl apply -f (Join-Path $basePath "worker-deployment.yml")

Write-Host "Deploying Ingress..."
kubectl apply -f (Join-Path $basePath "ingress.yml")

Write-Host "Deploying HPA..."
kubectl apply -f (Join-Path $basePath "hpa.yml")

Write-Host "Waiting for API deployment..."
kubectl rollout status deployment/project-2-api -n project-2 --timeout=300s

Write-Host "Waiting for Worker deployment..."
kubectl rollout status deployment/project-2-worker -n project-2 --timeout=300s

Write-Host "Waiting for Redis deployment..."
kubectl rollout status deployment/redis -n project-2 --timeout=300s

Write-Host "Deployment completed."