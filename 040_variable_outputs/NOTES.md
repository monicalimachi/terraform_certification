## Variables and Outputs

- terraform.tfvars
- additional variable files and -var-file
- additional autoloaded files
- -var
- TF_VAR_
- Outputs CLI
- Chaining outputs from a module
- Local values
- Data Sources

## Default tfvars
terraform.tfvars : It's loaded by default
```bash
    terraform plan 
```
## Other doc.tfvars
vars.tfvars : It's necessary load it and can  overwrite previous tfvars
```bash
    terraform plan -var-file=vars.tfvars
```

## Auto load other docs.tfvars
vars.auto.tfvars : It can overwrite all previous tfvars
```bash
    terraform plan 
```
## Add on the console vars
This overwrite all previous tfvars
```bash
    terraform plan -var=instance_type=t2.medium
```
## Terraform outputs
- 
```bash
terraform apply -refresh-only
terraform output -json
terraform output public_ip
terraform output -raw public_ip
terraform output -json | jq  -r ".public_ip.value"
```