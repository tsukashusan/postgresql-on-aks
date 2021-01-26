# PostgreSQL on Azure Kubernetes Service (AKS)

## STEP 1 Replace the  following strings in the file with any strings you wish.
However, please use only lowercase numbers and no symbols.
Passwords should include upper and lower case letters and numbers.

1. \_prefix\_
1. \_clientid\_
1. \_clientsecret\_
1. \_publickey\_
1. \_volumepath\_
1. \_postgresqldb\_
1. \_postgresqluser\_
1. \_postgresqlpassword\_

## STEP2 Execute Terraform
1. terraform init
1. terraform plan -out postgresql-on-k8s.plan
1. terraform apply "postgresql-on-k8s.plan"  