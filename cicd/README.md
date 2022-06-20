# Deploy CI/CD Setup with Ansible

Creates CI/CD Setup with Jenkins and ArgoCD in a Kubernetes Cluster.  
Manistests are ready-to-play with this [GCP](https://github.com/xvag/iac-demo/tree/main/gcp) / [Cluster](https://github.com/xvag/iac-demo/tree/main/cluster) Infrastructure.  
But can easily be applied to other setups, with very few changes.

Run the full deployment with:
```
$ ansible-playbook deploy-cicd.yml
```
or deploy specific setup with tags:
```
$ ansible-playbook deploy-cicd.yml -t <TAG>
```
where `<TAG>` can be:
- jenkins
- argocd

to create:  

### Jenkins
Jenkins Deployment for Continuous Integration.
- Access on [WORKER_EXTERNAL_IP]:31001
- Get Init password with:
```
$ kubectl -n jenkins exec -it [jenkins-pod-id] -- cat /var/jenkins_home/secrets/initialAdminPassword
```
replacing `[jenkins-pod-id]` with the actual pod ID of Jenkins.

#### ArgoCD
ArgoCD Deployment for Continuous Deployment.
- Acccess on [WORKER_EXTERNAL_IP]:31000
- Get Init password with:
```
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### Requirements
- Ansible with kubernetes modules
- kubectl
