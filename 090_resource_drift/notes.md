# Manage Resource drift

- Replacing resources: When a resource has become damaged or degraded that cannot be detected by Terraform we can use the "-replace" flag
- Importing resources: When an approved manual addition of resource needs to be added to our state file we use the import command
- Refresh state: When an approved manual configuration of a resource has changed or removed

## Replacing resources

- Deprecated - Only for Versions < 0.152: Terraform taint is used to mark resource for replacement, the next time you run apply
```bash
    terraform taint aws_instance.my_web_app
```
- Versions >=0.152: Use -replace flag and providing a resource address
```bash
    terraform apply -replace="aws_instance.example[0]"
```     

- A cloud resource can become degraded or damaged and you want to return the expected resource to a healthy state.

- The replace flag is available on plan and apply - works for a single resource

## Resource addressing

A resource address is a string that identifies zero or more resources instances in your configuration.
- An address is composed of two parts:

|1. [module path]                       | 2. [resource spec]                         |
|---------------------------------------|--------------------------------------------|
|module.module_name[module index]       | resource_type.resource_name[instance index]|
|A module path addresses a module within the tree of modules.    | A resource spec address a specific resource instance in the selected module |
|- module: Namespace for modules        |- resource_type: Type of the resource being addressed.   |
|- module_name: User-defined name of the module|- resource_name: User-defined name of the resource |
|- [module index]: When multiple specific a index    |- [instance index]: When multiple specific a index|

Example:
```
resource "aws_instance" "web" {
    count = 4
}

aws_instance.web[3] >> Select the third Virtual Machine
```
---
## Terraform import

Is used to import existing resources into Terraform
- Define a placeholder or your imported resource configration file
- You can leave the body blank and fill it in after importing. It will not be autofilled
```
resource "aws_instance" "example" {
    # ... instance configuration
}
```
- Proceed to importing your file: terraform import <RESOURCE_ADDRESS> <ID>
```
terraform import aws_instance.example i-0f9f8f9f
```
- The command can only import  one resource at a time
- Not all resources are importable, you need to check the bottom of resource documentation for support

---
## Terraform refresh 
- Terraform refresh reads the current settings from all managed remote objects and updates the terraform state to match
- Terraform refresh comand is an alias for the refresh onle and auto approve
- Terraform refresh will not modify your real remote objects, but it will modify the terraform state
```
terraform refresh -> terraform apply -refresh-only -auto-approve
```
- Terraform refresh has been deprecated and with the refresh-only flag because it was not safe since it did not give you an opportunity to review proposed changes before updating state file.

## Terraform refresh-only mode
-  The -refresh-only flag for terraform plan or apply allows you to refresh and update your state file without making changes to your remote infrastructure.

- "Scenario: Imagine you create a terraform script that deploys a Virtual Machine on AWS. You ask an engineer to terminate the server and instead of updating the terraform script they mistakenly terminate the server via the AWS Console".

 -------------- You run ------------------
|> terraform apply               |> terraform apply -refresh-only|
|-------------------------------|--------------------------------|
|- Terraform will notice that the VM is missing |- Terraform will notice that the VM you provisioned is missing|
|- Terraform will propose to create a new VM|- With the refresh-only flag the missing VM is intentional|
|- The state File is correct|- The state file is wrong|
|- Changes the infrastructure to match state file|- Changes the state file to match infrastructure|

