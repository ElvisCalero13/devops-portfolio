$ErrorActionPreference = "Stop"

Write-Host "Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

Write-Host "Adding Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

Write-Host "Installing kube-prometheus-stack..."
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack `
  --namespace monitoring `
  -f .\helm\monitoring-values.yml

Write-Host "Waiting for Grafana deployment..."
kubectl rollout status deployment/kube-prometheus-stack-grafana -n monitoring --timeout=300s

Write-Host "Waiting for Prometheus operator deployment..."
kubectl rollout status deployment/kube-prometheus-stack-operator -n monitoring --timeout=300s

Write-Host "Monitoring stack installed."
Write-Host "Use these commands to access:"
Write-Host "  kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80"
Write-Host "  kubectl port-forward svc/kube-prometheus-stack-prometheus -n monitoring 9090:9090"
Write-Host "Grafana credentials:"
Write-Host "  user: admin"
Write-Host "  password: admin"