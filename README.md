# GitOps CI/CD Pipeline (ArgoCD + Helm + Jenkins)

## 📌 Project Overview

This project demonstrates a **GitOps-driven CI/CD pipeline** using **Jenkins**, **Helm**, and **ArgoCD**. It ensures **reproducible deployments**, reduces **configuration drift**, and automates the **build, test, and deployment workflows** across multiple environments.

---

## 🚀 Features

* **GitOps Workflow**: Declarative deployments managed via Git repositories.
* **Jenkins CI**: Automated build, test, and container image publishing.
* **Helm Packaging**: Kubernetes application deployments managed with Helm charts.
* **ArgoCD CD**: Continuous Delivery with environment-specific ApplicationSets.
* **Environment Promotion**: Staging → Production workflow via GitOps.
* **Security & Compliance**: Enforced approvals, role-based access, and drift detection.

---

## 📂 Repository Structure

```bash
├── apps/
│   ├── sample-app/                 # Sample application source code
│   │   ├── Dockerfile
│   │   ├── src/
│   │   └── tests/
│   └── Jenkinsfile                 # Build, test, push to registry
│
├── helm-charts/
│   └── sample-app/                 # Helm chart for the sample app
│       ├── Chart.yaml
│       ├── templates/
│       └── values.yaml
│
├── argo-apps/
│   ├── dev/                        # Dev environment ArgoCD apps
│   ├── staging/                    # Staging environment ArgoCD apps
│   └── prod/                       # Production environment ArgoCD apps
│
├── jenkins/
│   └── Jenkinsfile.groovy          # CI pipeline definition
│
├── platform/
│   ├── argocd/                     # ArgoCD installation manifests
│   └── rbac/                       # Jenkins + ArgoCD RBAC configuration
│
└── README.md
```

---

## ⚙️ Pipeline Workflow

1. **Code Commit** → Developer pushes code to GitHub.
2. **Jenkins CI** → Jenkins triggers build:

   * Runs unit tests.
   * Builds and tags Docker image.
   * Pushes image to container registry.
   * Updates Helm chart values with new image tag.
3. **GitOps Commit** → Jenkins commits updated Helm values into GitOps repo.
4. **ArgoCD Sync** → ArgoCD detects repo changes and syncs to Kubernetes.
5. **Drift Detection** → ArgoCD continuously monitors and reports configuration drift.

---

## 🔧 Setup Instructions

### Prerequisites

* Kubernetes cluster (minikube, kind, or managed k8s)
* Jenkins installed in cluster (or external)
* ArgoCD installed in cluster
* Docker/Podman for local builds
* GitHub repository for GitOps manifests

### Installation Steps

1. **Install Jenkins**

   ```bash
   kubectl apply -f platform/jenkins/jenkins-deployment.yaml
   ```

2. **Install ArgoCD**

   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f platform/argocd/install.yaml
   ```

3. **Deploy Sample App**

   ```bash
   kubectl apply -f argo-apps/dev/sample-app.yaml
   ```

---

## ✅ Validation

* Confirm Jenkins builds run successfully.
* Check container image pushed to registry.
* Verify ArgoCD shows `Healthy` and `Synced` status.
* Ensure deployment propagates from **Dev → Staging → Prod** via GitOps promotion.

---

## 📊 Demo Flow

1. Make a code change in `apps/sample-app/src/`.
2. Jenkins builds and pushes new image.
3. Helm values are updated with new image tag.
4. ArgoCD auto-syncs the deployment.
5. Observe rollout in the Kubernetes cluster.

---

## 🔐 Security Highlights

* **RBAC**: Restricted permissions for Jenkins and ArgoCD.
* **Approvals**: Manual promotion gates for staging → production.
* **Drift Detection**: ArgoCD continuously monitors for unauthorized changes.

---

## 📈 Outcomes

* **Reduced Configuration Drift**: All changes tracked via Git.
* **Reproducible Deployments**: Versioned Helm charts + GitOps.
* **Faster Delivery**: Automated CI/CD with environment promotions.

---

## 🏆 Resume-Ready Highlight

**“Implemented GitOps workflows using ArgoCD, Helm, and Jenkins. Automated build, test, and deployment pipelines across environments, reducing configuration drift and improving delivery speed.”**

---

## 📚 References

* [ArgoCD Docs](https://argo-cd.readthedocs.io)
* [Helm Docs](https://helm.sh/docs/)
* [Jenkins Docs](https://www.jenkins.io/doc/)
