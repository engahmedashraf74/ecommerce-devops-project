# E-Commerce DevOps Platform

End-to-End DevOps project built on AWS using Terraform, Jenkins, Docker, EKS, ArgoCD, Prometheus, and Grafana.

## Architecture

GitHub → Jenkins → Amazon ECR → ArgoCD → Amazon EKS → Prometheus & Grafana

## Tech Stack

- AWS (EKS, ECR, VPC, IAM)
- Terraform
- Docker
- Jenkins
- Kubernetes
- ArgoCD
- Prometheus
- Grafana

## Features

- Infrastructure provisioning using Terraform
- Containerized microservices with Docker
- CI pipeline using Jenkins
- Image storage in Amazon ECR
- GitOps deployment using ArgoCD
- Kubernetes orchestration with EKS
- Monitoring with Prometheus & Grafana

## Deployment Flow

1. Developer pushes code to GitHub
2. Jenkins builds Docker images
3. Images are pushed to ECR
4. ArgoCD detects manifest changes
5. ArgoCD deploys to EKS
6. Prometheus collects metrics
7. Grafana visualizes dashboards

## Screenshots

### Jenkins Pipeline
<img width="1360" height="643" alt="VirtualBox_Ubuntu-VM_23_08_2026_12_47_01" src="https://github.com/user-attachments/assets/80ad42c6-99a3-4cad-923f-63090c70930d" />

### ArgoCD Dashboard
<img width="1360" height="643" alt="VirtualBox_Ubuntu-VM_23_08_2026_12_45_45" src="https://github.com/user-attachments/assets/4fceb8b3-aa80-40ef-a9f5-96189cbabe6d" />

### Grafana Dashboard
<img width="1891" height="912" alt="Screenshot 2026-08-23 123900" src="https://github.com/user-attachments/assets/4af5da03-9dd5-4d74-8081-280f931528ee" />

## Challenges Faced

### EKS Node Group Creation Failure
- Cause: AWS vCPU quota limit exceeded
- Solution: Increased quota and recreated node group

### Kubernetes Unauthorized Error
- Cause: System time drift
- Solution: Re-synced system time and updated kubeconfig

### ImagePullBackOff
- Cause: Images were pushed with build tags only
- Solution: Updated Jenkins pipeline to push `latest` tag

## Result

Successfully implemented a production-style DevOps platform with:

- Infrastructure as Code
- CI/CD Automation
- GitOps Deployment
- Kubernetes Orchestration
- Monitoring & Observability

## Author

Ahmed Ashraf
