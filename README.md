# 🚀 DevOps Portfolio – Cloud & Data Engineering

![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-blue)
![Serverless](https://img.shields.io/badge/Architecture-Serverless-green)
![CI/CD](https://img.shields.io/badge/CI/CD-GitHub_Actions-black)

---

## 📌 Overview

This repository showcases a collection of **real-world DevOps, Cloud, and Data Engineering projects** built using AWS, Kubernetes, Terraform, and CI/CD pipelines.

Each project focuses on a different domain:

* CI/CD automation
* Container orchestration
* Serverless data pipelines
* Infrastructure as Code (IaC)
* Monitoring and observability

---

## 🧠 About Me

Cloud & Data Engineer with experience designing scalable infrastructure, automating deployments, and building data pipelines.

* AWS Certified Solutions Architect – Associate
* Focus on DevOps, Platform Engineering, and Data Engineering
* Experience with microservices, CI/CD, and cloud-native architectures

---

## 🧱 Projects

---

### 🚀 Project 1 – CI/CD Pipeline on AWS ECS (Fargate)

**Focus:** DevOps / CI/CD / Containers

**Stack:**

* GitHub Actions
* Docker
* Amazon ECR
* Amazon ECS (Fargate)
* Application Load Balancer
* CloudWatch + SNS
* Terraform

**Highlights:**

* Fully automated CI/CD pipeline
* Infrastructure provisioned via Terraform
* Docker image build and deployment to ECS
* Monitoring with CloudWatch dashboards and alarms
* Email alerts via SNS

👉 [`project-1-cicd`](./project-1-cicd)

---

### ☸️ Project 2 – Kubernetes Microservices Platform

**Focus:** Kubernetes / Orchestration / Observability

**Stack:**

* Kubernetes (kind)
* Helm
* NGINX Ingress
* Horizontal Pod Autoscaler (HPA)
* Prometheus & Grafana
* Go (API + worker)
* Redis

**Highlights:**

* Microservices architecture (API + worker)
* Autoscaling with HPA
* Load testing with BusyBox
* Monitoring stack with Prometheus & Grafana
* Ingress routing and service exposure

👉 [`project-2-kubernetes`](./project-2-kubernetes)

---

### 📊 Project 3 – Serverless Data Pipeline on AWS

**Focus:** Data Engineering / Serverless / Event-driven

**Stack:**

* Amazon S3 (raw, processed, results)
* AWS Lambda
* AWS Glue Data Catalog
* Amazon Athena
* CloudWatch + SNS
* Terraform
* GitHub Actions (OIDC)

**Highlights:**

* Event-driven architecture using S3 triggers
* Data transformation via Lambda
* Queryable datasets using Athena
* Infrastructure as Code with Terraform (modular)
* Secure CI/CD using OIDC (no static credentials)
* Monitoring and alerting pipeline

👉 [`project-3-data-pipeline`](./project-3-data-pipeline)

---

## ⚙️ Core Skills Demonstrated

* Infrastructure as Code (Terraform)
* CI/CD automation (GitHub Actions)
* Containerization (Docker)
* Orchestration (Kubernetes)
* Serverless architectures (AWS Lambda)
* Data pipelines (S3, Glue, Athena)
* Monitoring & Observability (CloudWatch, Prometheus, Grafana)
* Cloud networking and security (IAM, VPC, OIDC)

---

## 🔐 Security Practices

* OIDC authentication between GitHub and AWS
* No hardcoded credentials
* Least privilege IAM policies
* Environment-based configurations

---

## 💰 Cost Awareness

All projects are designed with **cost efficiency in mind**:

* Serverless where possible
* Minimal always-on infrastructure
* Suitable for portfolio/demo environments

---

## 📈 Future Improvements

* Multi-environment deployments (dev/stage/prod)
* Advanced CI/CD with approvals and promotion pipelines
* Centralized logging and observability
* Terraform remote state standardization across projects

---

## 📫 Contact

* LinkedIn: https://www.linkedin.com/in/elvis-calero-manueles
