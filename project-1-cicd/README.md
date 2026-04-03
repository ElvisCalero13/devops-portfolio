# 🚀 Project 1 – CI/CD Pipeline on AWS ECS

[![CI](https://github.com/elviscalero13/devops-portfolio/actions/workflows/project-1-cicd.yml/badge.svg)](https://github.com/elviscalero/devops-portfolio/actions/workflows/cicd.yml)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4)
[![Quality](https://github.com/elviscalero13/devops-portfolio/actions/workflows/project-1-quality.yml/badge.svg)](https://github.com/elviscalero13/devops-portfolio/actions/workflows/project-1-quality.yml)
![AWS ECS](https://img.shields.io/badge/AWS-ECS_Fargate-orange)
![Monitoring](https://img.shields.io/badge/monitoring-CloudWatch-blue)
![Alerts](https://img.shields.io/badge/alerts-SNS-yellow)

## 📌 Overview

This project demonstrates a complete **end-to-end CI/CD pipeline** for a containerized FastAPI application deployed on AWS.

It includes modern DevOps practices such as:

- Infrastructure as Code (Terraform)
- Secure authentication using GitHub OIDC
- Automated deployments to ECS Fargate
- Code quality analysis with SonarCloud
- Monitoring and alerting with CloudWatch and SNS

---

## 🏗️ Stack

- FastAPI
- Docker
- GitHub Actions (CI/CD)
- Amazon ECR
- Amazon ECS (Fargate)
- Terraform
- SonarCloud
- AWS CloudWatch
- AWS SNS

---

## ⚙️ Features

- CI/CD pipeline with GitHub Actions
- Docker image build and push to ECR
- Deployment to ECS Fargate
- Infrastructure as Code using Terraform
- Code quality analysis with SonarCloud
- CloudWatch monitoring dashboard
- CloudWatch alarms for system health
- SNS email notifications for alerts

🔜 Planned:

- Automatic rollback (deployment circuit breaker)
- Advanced health checks (/live, /ready)

---

## 🔁 CI/CD Pipeline

### 1. Quality Pipeline (`quality.yml`)

- Runs on pull requests
- Executes:
  - unit tests
  - coverage report
  - SonarCloud analysis

---

### 2. Deployment Pipeline (`cicd.yml`)

- Runs on push to `main`
- Executes:
  - Terraform plan & apply
  - Docker build & push
  - ECS deployment

---

## 🧪 Code Quality (SonarCloud)

This project integrates **SonarCloud** for continuous code quality inspection.

- Static code analysis
- Code coverage (pytest + coverage)
- Detection of bugs, vulnerabilities, and code smells
- Quality checks executed in CI pipeline

👉 SonarCloud runs automatically on pull requests and helps maintain clean, reliable code.

> Note: Quality Gates enforcement is planned as a next step.

---

## 📊 Monitoring & Observability

### 📈 CloudWatch Dashboard

A custom CloudWatch dashboard is provisioned using Terraform and includes:

- ECS CPU utilization
- ECS memory utilization
- ALB request count
- ALB response time
- ALB 5XX errors
- Unhealthy targets

👉 Provides real-time visibility into application and infrastructure health.

---

### 🚨 CloudWatch Alarms

The system includes proactive monitoring through alarms:

| Alarm             | Description        |
| ----------------- | ------------------ |
| ECS CPU High      | High CPU usage     |
| ECS Memory High   | High memory usage  |
| ALB 5XX Errors    | Application errors |
| Unhealthy Targets | Failing containers |

👉 Helps detect issues early before impacting users.

---

### 📧 SNS Email Alerts

All CloudWatch alarms are connected to an **Amazon SNS topic**.

- Email notifications are sent when alarms are triggered
- Alerts also notify when systems recover

👉 Enables real-time incident awareness and faster response.

> Note: Email subscription requires manual confirmation.

---

## 🔁 Safe Deployments (Planned)

Automatic rollback using ECS deployment circuit breaker is planned for future implementation.

```hcl
deployment_circuit_breaker {
  enable   = true
  rollback = true
}
```

👉 This will ensure that failed deployments are automatically reverted to the last stable version.

> Status: 🔜 Not implemented yet

---

## ❤️ Health Checks (Planned)

Advanced health checks will be implemented to improve deployment reliability:

- `/health/live` → verifies container is running
- `/health/ready` → verifies application readiness

These will be used by:

- ECS container health checks
- Application Load Balancer

👉 This allows better failure detection and safer deployments.

> Status: 🔜 Not implemented yet

---

## ▶️ Run with Docker

```bash
chmod +x scripts/run-docker.sh
./scripts/run-docker.sh
```

---

## 🌐 Endpoints

- `/`
- `/health`
- `/version`

---

## 💰 Cost Considerations

- Uses AWS Fargate with minimal resources
- Designed to run at low cost (~$0–$5/month)
- Can be removed with:

```bash
terraform destroy
```

---

## 🎯 Project Goals

- Demonstrate end-to-end CI/CD pipeline
- Showcase AWS ECS deployment with Terraform
- Implement real-world DevOps practices
- Include monitoring and alerting
- Maintain a cost-efficient and production-ready setup

---

## 🧠 What This Project Demonstrates

- CI/CD automation with GitHub Actions
- Secure cloud authentication (OIDC)
- Infrastructure as Code (Terraform)
- Container orchestration (ECS)
- Monitoring and alerting (CloudWatch + SNS)
- Code quality practices (SonarCloud integration)

---
