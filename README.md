# Deploy Complete Infrastructure for a Demo App (Instavote)

Deploy the Infrastructure for [Instavote App](https://github.com/xvag/instavote-ci), as-Code with Terraform and Ansible.  
(GCP Infra, Kubernetes Cluster, CI/CD, Monitoring, SecOps)

### The Big Picture:  
After applying all the present manifests you will have:
- Five VMs on GCP (2 controllers, 2 workers, 1 for Nagios Server)
- A Kubernetes Cluster with HA, on 2 controllers and 2 workers.
- Monitoring with Nagios, Prometheus/Grafana, Kubernetes Dashboard and KubeOpsView.
- Continuous Integration setup with Jenkins
- Continuous Deployment setup with ArgoCD

(Follow the links below for the instructions of the next steps)

## Steps:

01. [Deploy Infrastructure on GCP with Terraform.](https://github.com/xvag/instavote-infra/tree/main/gcp)
02. [Deploy the Kubernetes Cluster with Ansible.](https://github.com/xvag/instavote-infra/tree/main/cluster)
03. [Deploy Monitoring Infra with Ansible.](https://github.com/xvag/instavote-infra/tree/main/monitoring)
04. [Deploy CI/CD Infra.](https://github.com/xvag/instavote-infra/tree/main/cicd)
