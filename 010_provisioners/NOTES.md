# Provisioning using cloud init

## Migrate from Cloud to Local Backend
1. Verify the states on Terraform Cloud
2. Verify Cloud exist locally
```bash
cloud {
    organization = "los-patitos"
    workspaces {
      name = "provisioners"
    }
  }
```
3. Create folders in the same Terraform dir
```bash
    mkdir terraform.tfstate.d
    mkdir terraform.tfstate.d/NAME_WORKSPACE
```
4. Remove file terraform.tfstate from .terraform folder to only maintain 1 conf state file.
5. Run command to pull last cloud change to local backend
```bash
    terraform state pull> ./terraform.tfstate.d/NAME_WORKSPACE/terraform.tfstate
``` 
6. Now remove or comment cloud terraform config
```bash
#cloud {
#    organization = "los-patitos"
#    workspaces {
#      name = "provisioners"
#    }
#  }
```
6. Run command terraform init to start state backend locally in the workspace defined
```bash
    terraform init
```