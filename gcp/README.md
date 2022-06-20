# Deploy Infrastructure on GCP with Terraform

Creates 5 VMs on GCP: 4 for a Kubernetes Cluster and 1 for Nagios Server.

Based on [Kubernetes the Hard Way as Code - GCP Infra](https://github.com/xvag/k8s-iac-thw/tree/main/gcp)
+ one extra VM for Nagios (hardcoded variables in the main.tf).

### Deploy from Terraform Cloud

01. Create a new Workspace on Terraform Cloud and connect it with the GitHub repo.  
Set Terraform Working Directory to the gcp/ folder.  
Set Run Trigger to "Only trigger runs when files in specified paths change", pointing to gcp/ folder.

02. Create the following workspace variables (as sensitive):
- gcp_project = The GCP Project ID
- grc_creds   = The Service Account Key for the GCP Project ([More info](https://stackoverflow.com/questions/68290090/set-up-google-cloud-platform-gcp-authentication-for-terraform-cloud))
- ssh_user = username for ssh user
- ssh_key  = .pub key of the ssh user
