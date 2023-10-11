kubergrunt is a CLI tool developed by Gruntwork that assists in setting up and managing a Kubernetes (K8s) cluster, particularly with EKS (Amazon's Kubernetes Service). It provides a collection of commands that fills in the gaps between Terraform, Helm, and K8s.

To install kubergrunt, follow these steps:

took latest version 
https://github.com/gruntwork-io/kubergrunt/releases
 in my case v0.12.1
wget https://github.com/gruntwork-io/kubergrunt/releases/download/v0.12.1/kubergrunt_linux_amd64 -O kubergrunt

chmod +x kubergrunt

sudo mv kubergrunt /usr/local/bin/

kubergrunt --version
