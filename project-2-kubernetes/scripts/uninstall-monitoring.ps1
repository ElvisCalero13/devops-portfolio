$ErrorActionPreference = "Stop"

Write-Host "Uninstalling monitoring stack..."
helm uninstall kube-prometheus-stack -n monitoring

Write-Host "Deleting monitoring namespace..."
kubectl delete namespace monitoring --ignore-not-found=true

Write-Host "Done."