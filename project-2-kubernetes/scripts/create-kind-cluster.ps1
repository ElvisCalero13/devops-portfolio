$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$configPath = Join-Path $scriptDir "kind-config.yml"

Write-Host "Deleting existing kind cluster if it exists..."
kind delete cluster --name project-2

Write-Host "Creating kind cluster..."
kind create cluster --config $configPath
if ($LASTEXITCODE -ne 0) { throw "kind create cluster failed" }

Write-Host "Installing ingress-nginx..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
if ($LASTEXITCODE -ne 0) { throw "ingress-nginx install failed" }

Write-Host "Waiting for ingress controller deployment..."
kubectl rollout status deployment/ingress-nginx-controller `
  -n ingress-nginx `
  --timeout=300s

if ($LASTEXITCODE -ne 0) {
  throw "ingress controller not ready"
}

Write-Host "Installing metrics-server..."
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
if ($LASTEXITCODE -ne 0) { throw "metrics-server install failed" }

Write-Host "Patching metrics-server for kind..."
$patchPath = Join-Path $scriptDir "metrics-server-patch.json"
kubectl patch deployment metrics-server `
  -n kube-system `
  --type json `
  --patch-file $patchPath

if ($LASTEXITCODE -ne 0) { throw "metrics-server patch failed" }

Write-Host "Waiting for metrics-server..."
kubectl rollout status deployment/metrics-server -n kube-system --timeout=300s
if ($LASTEXITCODE -ne 0) { throw "metrics-server not ready" }

Write-Host "Kind cluster is ready."