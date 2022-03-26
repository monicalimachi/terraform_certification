# terraform_certification
- Create main.tf
- Add AWS Provider
- Generate, configure AWS Credentials
- Configure AWs VM
- Initialize terraform project
- Terraform fmt
- Terraform validate
- Terraform plan
- Terraform apply
- Terraform apply (updating)
- Create input variables
- Set Locals
- Create outputs
- Use a terraform Module
- Divide project into multiple files
- Terraform destroy
- Create a terraform Cloud workspace
- Migrate local to remote workspace
- Move AWs Credentials to env vars


Commands:
```bash
terraform init
terraform validate
terraform plan
terraform plan -var=instance_type="t2.micro"
terraform apply
terraform apply -auto-approve
terraform apply -destroy
terraform destroy
```
To refresh, you can use:
```bash
terraform apply -refresh-only
```

Review expressions:
- strings: https://www.terraform.io/language/expressions/strings

## SSH
```bash
ssh ec2-user@$(terraform output -raw public_ip) -i $HOME/.ssh/ssh_key
```

## Debug
To enable debug mode:
```bash
export TF_LOG=TRACE
terraform apply -no-color 2>&1 | tee apply.txt
```
To remove debug mode:
```bash
unset TF_LOG
```
