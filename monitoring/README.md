# Deploy Monitoring Infra with Ansible

Creates monitoring setup for the ([GCP](https://github.com/xvag/iac-demo/tree/main/gcp) / [Cluster](https://github.com/xvag/iac-demo/tree/main/cluster)) infrastructure.

Run the deployment with:
```
$ ansible-playbook deploy-monitoring
```

to create:

#### Nagios
Deploy Nagios Monitoring with Ansible:
- Setup Nagios Server on a separate VM in GCP.
- Setup Kubernetes Nodes as Nagios Clients.
- Access on [NAGIOS_EXTERNAL_IP]/nagios
- Init login with: nagiosadmin/nagiosadmin

#### KubeOpsView
KubeOpsView Deployment on the Kubernetes Cluster.
- Access on [WORKER_EXTERNAL_IP]:32000

#### Kubernetes Dashboard
Kubernetes Dashboard Deployment on the Kubernetes Cluster.
- Acccess on [WORKER_EXTERNAL_IP]:32010
- Get login token with:
```
$ kubectl -n kubernetes-dashboard create token admin-user
```

#### Prometheus/Grafana
A complete Prometheus/Grafana Deployment on the Kubernetes Cluster,  
with kube-state-metrics, alert-manager and node-exporter.
- Access Prometheus on [WORKER_EXTERNAL_IP]:32001
- Access Alert-Manager on [WORKER_EXTERNAL_IP]:32002
- Access Grafana on [WORKER_EXTERNAL_IP]:32003
- Login to Grafana with admin/admin


### Requirements:
For Nagios Setup:
- Ansible
- gcloud CLI  

For the rest:
- Ansible with kubernetes module
- kubectl (configured to the cluster)
