# Deploy Monitoring Infra with Ansible

Creates monitoring setup for the ([GCP](https://github.com/xvag/iac-demo/tree/main/gcp) / [Cluster](https://github.com/xvag/iac-demo/tree/main/cluster)) infrastructure.

Running the deployment with:
```
ansible-playbook deploy-monitoring
```

will create:

#### Nagios
Deploy Nagios Monitoring with Ansible:
- Setup Nagios Server on a separate VM in GCP.
- Setup Kubernetes Nodes as Nagios Clients.

#### KubeOpsView
Deploy KubeOpsView
