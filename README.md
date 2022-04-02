# terraform_certification
Terraform current version: 4.6.0
Ubuntu hirsute: 21.04

# Terraform Documentation
## Variable and outputs
Variable Definition: In this order the last will override the previous. 
- Environment variables
- terraform.tfvars
- terraform.tfvars.json
- *.auto.tfvars or *.auto.tfvars.json
- -var and -var-file

Output files: Retuns actions
- terraform output > returns all the outputs in a statefile 
- terraform output lb_url > It returns a specific output with that name
- terraform output -json > It returns outputs in json format
- curl $(terraform output -raw lb_url) > it returns some HTML response

Local values: Declare local values
```bash
locals{
    service_name="forum"
    owner="Comunity team"
}
locals{
    instance_ids=(aws_instance.blue.*.id,aws_instance.green.*.id)
}
locals{
    common_tags={
        Service=local.service_name
        Owner=local.owner
    }
}
```
- After declare values, it can be referenced in expressions as local.<NAME>
```bash
resource "aws_instance" "example"{
    tags = local.common_tags
}
```

Data Sources: allow use Information outside of terraform, defined by another terraform configuration or modified by functions.
```bash
data "aws_ami" "web"{
    filter{
        name=state
        values=["available"]
    }
    filter{
        name="tag:Component"
        values=["web"]
    }
    most_recent= true
}
```
- It can be referenced to:
```bash
    resource "aws_instance" "web"{
        ami = data.aws_ami.web.id
        instance_type = "t1.micro"
    }
```
Named values: Are built-in expressions to reference various values such as:
- Resources: <ResourceType>.<Name> eg: aws_instance.my_server
- Input variables: var.<Name>
- Local values: local.<Name>
- Child module outputs: module.<Name>
- Data Sources: data.<Data Type>.<Name>
 Filesystem and workspace info:
* path.module - path of the module where the expression is placed
* path.root - path of the root module of the configuration
* path.cwd - path of the current working directory
* terraform.workspace - name of the currently selected workspace
 Block-local values (within the body of blocks)
 * count.index(when you use the count meta argument)
 * each.key / each.value (when you use the for_each meta argument)
 * self.<attribute> - self reference information within the block (provisioners and connections)

 # Named values resemble the attribute notation for map (object) values but are not objects and do not act as objects. Tou cannot use squere brackets to access attribute of Named Values like an object.


Primary helpful commands:
## SSH connection
```bash
ssh ec2-user@$(terraform output -raw public_ip) -i $HOME/.ssh/PRIVATE_EC2_KEY
```
## Resource meta-arguments
- depends-on
- count
- alias
- lifecycle

## Types and values
- Primitive types
1. string
```bash
    ami = "ami-830c94e3"
```
2. number
```bash
    size = 6.2831
```
3. Boolean
```bash
    termination_protection = true
```
- no type
1. null : null represent absence or omission when you want to use the underlying default of a provider's resource configuration option
```bash
    endpoint = null
```
- complex/structural/collection types
1. list (tuple)
```bash
    region = ["us-east-1a","us-east-1b"]
```
2. map (object)
```bash
    tags = {env = "Production", priority = 3}
```