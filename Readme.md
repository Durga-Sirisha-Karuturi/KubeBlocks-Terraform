# Terraform KubeBlocks PostgreSQL Platform

PostgreSQL platform automation using Terraform, Kubernetes, Helm, and KubeBlocks.

This project automates:

- PostgreSQL HA cluster deployment
- Primary and Read Replica services
- MinIO backup integration
- WAL-G scheduled backups
- Continuous WAL archiving
- pgvector extension enablement
- pgAdmin PostgreSQL management UI

---

# Architecture

```text
Terraform
   │
   ├── Infrastructure Module
   │      ├── Snapshot Controller
   │      ├── KubeBlocks CRDS
   │      └── KubeBlocks Helm
   │
   ├── PostgreSQL Module
   │      ├── PostgreSQL HA Cluster
   │      ├── Primary LoadBalancer
   │      ├── Read Replica LoadBalancer
   │      └── Postgresql DB Password
   │
   ├── Backup Module
   │      ├── BackupRepo
   │      ├── WAL-G Full Backups Schedule
   │      ├── WAL Archiving Schedule
   │
   │
   ├── pgvector Module
   │      └── PostgreSQL Vector Extension
   │
   └── pgAdmin Module
          └── PostgreSQL Web UI
```

---

# Installation

## Clone Repository

```bash
git clone <repository-url>

cd terraform-kubeblocks
```

---

## Initialize Terraform

```bash
terraform init
```

---

## Configure Variables

Edit:

```bash
vim terraform.tfvars
```

---

## Deploy Infrastructure

```bash
terraform apply -auto-approve
```

---

# Verify Deployment

## PostgreSQL Pods

```bash
kubectl get pods -n postgres
```

---

## PostgreSQL Services

```bash
kubectl get svc -n postgres
```

---

## Backup Repository

```bash
kubectl get backuprepo -n postgres
```

---

## Backup Schedules

```bash
kubectl get backupschedules -n postgres
```

---

## pgvector OpsRequests

```bash
kubectl get opsrequest -n postgres
```

---

## pgAdmin Service

```bash
kubectl get svc -n pgadmin
```

---

# Service Purpose

| Service | Purpose |
|---|---|
| pglb | Primary writable endpoint |
| pglb-read | Read replica endpoint |

---

# pgAdmin Access

## Get NodePort

```bash
kubectl get svc -n pgadmin
```

---

## Open

```text
http://<NODE-IP>:<NODEPORT>
```

---

## Login

```text
Email: admin@gmail.com

Password: admin123
```
