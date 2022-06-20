# Deploy Infrastructure on GCP with Terraform

### Deploy from Terraform Cloud

01. Create a new Workspace on Terraform Cloud and connect it with the GitHub repo.  
Set Terraform Working Directory to the gcp/ folder.  
Set Run Trigger to "Only trigger runs when files in specified paths change", pointing to gcp/ folder.


02. Create the following workspace variables (as sensitive):
- gcp_project = The GCP Project ID
- grc_creds   = The Service Account Key for the GCP Project ([More info](https://stackoverflow.com/questions/68290090/set-up-google-cloud-platform-gcp-authentication-for-terraform-cloud))
- ssh_user = username for ssh user
- ssh_key  = .pub key of the ssh user
