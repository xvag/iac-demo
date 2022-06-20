# Complete Infrastructure as Code Demo

Deploy Infrastructure-as-Code with Terraform and Ansible.  
(GCP Infra, Kubernetes Cluster, CI/CD, Monitoring, SecOps)

### The Big Picture:  
Applying successfully all the present manifests will create:
- Five VMs on GCP (2 controllers, 2 workers, 1 for Nagios Server).
- A Kubernetes Cluster with HA, on 2 controllers and 2 workers.
- Monitoring setup with Nagios, Prometheus/Grafana, Kubernetes Dashboard and KubeOpsView.
- Continuous Integration setup with Jenkins.
- Continuous Deployment setup with ArgoCD.

Specific parts of the Infra, instead of all, can by deployed using the Ansible flags in the manifests.

#### Requirements:
The following should be installed in the host from which the manifests will run.
- Ansible
- gcloud CLI
- cfssl
- kubectl

Follow the links below for further instructions of the next steps.

## Steps:

01. [Deploy Infrastructure on GCP with Terraform.](https://github.com/xvag/instavote-infra/tree/main/gcp)
02. [Deploy the Kubernetes Cluster with Ansible.](https://github.com/xvag/instavote-infra/tree/main/cluster)
03. [Deploy Monitoring Infra with Ansible.](https://github.com/xvag/instavote-infra/tree/main/monitoring)
04. [Deploy CI/CD Infra.](https://github.com/xvag/instavote-infra/tree/main/cicd)
