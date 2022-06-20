# Deploy Infrastructure on GCP with Terraform

### Deploy from Terraform Cloud

01. Create a new Workspace on Terraform Cloud and connect it with the GitHub repo.

02. Create the following workspace variables (as sensitive):
- gcp_project = The GCP Project ID
- grc_creds   = The Service Account Key for the GCP Project ([More info](https://stackoverflow.com/questions/68290090/set-up-google-cloud-platform-gcp-authentication-for-terraform-cloud))

For connecting to the VMs through SSH:
- ssh_user = username for ssh user
- ssh_key  = .pub key of the ssh user
