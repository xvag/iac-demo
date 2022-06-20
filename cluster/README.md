# Deploy Kubernetes Cluster using Ansible

Creates a Kubernetes Cluster with High-Availability on 2 Controllers and 2 Workers.

Based on [Kubernetes the Hard Way as Code - Cluster Infra](https://github.com/xvag/k8s-iac-thw/tree/main/cluster), plus:
+ 2 extra steps in the Post Deploy Role (install Docker and create PV directories).

### Deploy with Ansible
01. [GCP Infra](https://github.com/xvag/iac-demo/tree/main/gcp) should be ready and running.
02. Must have installed and configured:
- Ansible
- gcloud CLI (connected with the relevant project)
- cfssl (for the licenses)
- kubectl
03. Deploy with:
```
$ ansible-playbook deploy-cluster.yml
```
