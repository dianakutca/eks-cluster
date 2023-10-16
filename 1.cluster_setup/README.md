# Deploying EKS Cluster 
### Configure backend
```
source ../scripts/setenv.sh 
```
#### Apply
```
terraform apply -var-file ../0.account_setup/configurations.tfvars
```

### Run the below command to update the configfile and get kubectl ready to use 
``````
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
``````

### File config-map-aws-auth.yaml has been created, please run the below to get access to your nodes: 
``````
kubectl apply -f config-map-aws-auth.yaml 
``````