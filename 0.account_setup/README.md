# Instructions

----
### Step1
Please navigate to 
```
https://aws.amazon.com
```
----
### Step2
#### Login with your brand new account
#### Create new bucket call it 
```
terraform-project-WHATEVER_YOU_WANT      # It should start with terraform-project
Make sure it is in us-east-1 region
```
### Step3
#### Create user and keys for him to connect AWS to your account 

        Please setup your account
        1. Create AWS IAM user with admin privileges
        2. Create access and secret key 
        3. run 
            
                aws configure    
                    Add Access key
                    Add Secret  Key
                    Add Region  (I really mean that, please add, otherwise you are going to cry)
                    Add Format

----
### Step3
#### Create a new file here called 
```
0.account_setup/configurations.tfvars
```
#### and add the following message there 
```
# Please get your AWS Domain
domain_name = "AWS_DOMAIN"

# Use AWS account email
email              = "EMAIL"

# Add bucketname you created above
bucket_name        = "terraform-project-WHATEVER_YOU_WANT"

# Add your AWS Account ID
aws_account = "YOUR_AWS_ACCOUNT_NUMBER"
```
----
### Step4
Check script scripts/login.sh and choose option if you need download kubectl on MAC or LINUX or add commands for your OS (by default its set for Linux)

---

Run:
```
source ../scripts/login.sh  (or bash ../scripts/login.sh)

```





aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)


kubectl -n nginx-ingress port-forward svc/nginx-ingress-ingress-nginx-controller 8443:443
kubectl -n nginx-ingress port-forward svc/<nginx-service-name> 8443:443

kubectl describe service nginx-ingress-ingress-nginx-controller -n nginx-ingress

terraform apply -var-file ../0.account_setup/configurations.tfvars


domain_name = "treenetsolution.com"
email       = "dianakutca14@gmail.com"
bucket_name = "terraform-project-dianakutca-eks-setup"
aws_account = "816953616995"
region = "us-east-1"