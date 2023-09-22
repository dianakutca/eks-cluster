module "vpc" {
    source = "../modules/vpc"
    region          = "us-east-1"
cidr_block      = "10.100.0.0/16"
public_subnet1  = "10.100.1.0/24"
public_subnet2  = "10.100.2.0/24"
public_subnet3  = "10.100.3.0/24"
private_subnet1 = "10.100.101.0/24"
private_subnet2 = "10.100.102.0/24"
private_subnet3 = "10.100.103.0/24"
}