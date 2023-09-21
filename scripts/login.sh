#!/bin/bash

# Set current folder
DIR=$(pwd)

### Set color
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Check if kubectl is already installed
if command -v kubectl &>/dev/null; then
    echo "${green}kubectl is already installed. Please continue.${reset}"
else
    aws sts get-caller-identity   > /dev/null
if [ $? == 0 ]; 
then 
    ####FOR LINUX####
    # Setup Kubectl get ns 
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.15/2023-01-11/bin/linux/amd64/kubectl --silent
    chmod +x kubectl
    # Create the destination directory if it doesn't exist
    mkdir -p ~/.local/bin
    mv kubectl ~/.local/bin
    echo ${green}"Please continue" ${reset}

    # # Download the macOS version of kubectl on MAC
    # curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl" --silent
    # # Make the kubectl binary executable
    # chmod +x kubectl
    # # Move kubectl to a directory that's in your PATH (e.g., /usr/local/bin)
    # sudo mv kubectl /usr/local/bin
    # echo ${green}"Please continue" ${reset}

    else 
        echo ${red} """
            Please set up your account
            1. Create AWS IAM user with admin privileges
            2. Create access and secret key 
            3. run 
            
                aws configure    
                    Add Access key
                    Add Secret  Key
                    Add Region  (I really mean that, please add, otherwise you are going to cry)
                    Add Format          
        
        """${reset}
    fi 
fi  # This closes the outer if statement

# Check if AWS CLI has been configured with required data
if aws configure get aws_access_key_id &>/dev/null &&
   aws configure get aws_secret_access_key &>/dev/null &&
   aws configure get region &>/dev/null; then
    echo "${green}AWS CLI is configured with the required data. Please continue.${reset}"

else 
    echo ${red} """
        AWS CLI is not configured with the required data. Please set up your AWS CLI:
        1.Please set up your account
            1. Create AWS IAM user with admin privileges
            2. Create access and secret key 
        2. Run 'aws configure':
           - Add Access key
           - Add Secret Key
           - Add Region (I really mean that, please add, otherwise you are going to cry)
           - Add Format
    """${reset}

fi  # This closes the outer if statement


if [ ! -f configurations.tfvars ];
then 
    echo """
        Please create 0.account_setup/configurations.tfvars
        And add the necessary values from README.md
    """
    exit 1
else 
    echo ${green}"configurations.tfvars file is created" ${reset}
fi

# Setup python aws cli


  git config --global user.email "dianakutca14@gmail.com"
  git config --global user.name "dianakutca"