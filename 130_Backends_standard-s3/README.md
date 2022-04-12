Each terraform configuration can specify a backend, which defines where and how operations are performed, where state snapshots are stored

Terraform backends are divided into two types:
### Standard Backends
- only store state
- does not perform terraform operations e.g.: Terraform apply
    * To perform operations you use the CLI on your local machine
- third-party backends are Standard backends e.g. AWS S3

### Enhanced Backends
- can both store state
- can perform terraform operations

enhanced backends are subdivided further:
- local: files and data are stored on the local machine executing terraform commands
- remote: files and data are stored in the cloud e.g. Terraform Cloud

## Standard Backends
- Simple Storage Service (S3) locking via DynamoDB > AWS Cloud Storage
- AzureRM with locking > Blob Storage account
- Google Cloud Storage(GCS) with locking > Google Cloud's object Storage
- Alibaba Cloud Object Storage Service (OSS) locking via TableStore  >  Cloud Storage
- OpenStack Swift with locking > Rackspace's OpenStack Private Cloud Storage
- Tencent Cloud Object Storage (COS) with locking
- Manta(Triton Object Storage) with locking > Joynet's Cloud Storage
- Artifactory no locking a universal repository manager
- Hashicorp Consul with locking > service networking platform (service mesh)
- etcd no locking and etcdv3 with locking > A distributed, reliable key-value store for the most critical data of a distributed system
- Postgres database with locking > Relational database
- Kubernetes secret with locking > secrets storage in k8s cluster
- HTTP protocol optional locking > Use REST API to setup a custom remote backend

### Example with S3: 
Configuring a standard backend does not require a Terraform Cloud account or workspace
```HCL
backend "s3" {
  bucket = "my-bucket"
  key    = "my-key"
  region = "us-east-1"
}
```

### Local Backends
1. Local backend:
- Stores state on the local filesystem
- locks taht state using system APIs
- performs operations locally
- By default you are using the backend state when you have no specified backend
```HCL
terraform{
}
```
- You specific the backend with argument local, and you can change the path to the local file and working_directory
```HCL
terraform {
  backend "local"{
    path = "relative/path/to/terraform.tfstate"
  }
}
```

- You can set a backend to reference another state file so you can read its outputted values. this is a way of cross-referencing stacks: 
```HCL
data "terraform_remote_state" "networking"{
  backend = "local"
  config = {
    path = "${path.module}/networking/terraform.tfstate"
  }
}
```
### Remote backends changed to 
- When using a remote backend you need to set a Terraform Cloud Workspaces:
- You can set a  single wokspace via name
```HCL
workspaces{
  name = "my-workspace"
}
```
- You can set multiple workspaces via prefix
```HCL
workspaces{
  prefix = "my-workspace-"
}
```
  On terraform apply you will have to choose which workspace you want to apply the operation:

* Setting both name and prefix will result in an error:

### Backend initialization
https://www.terraform.io/language/settings/backends 
- The -backend-config flag for terraform init can be used for partial backend configuration
- In situations where the backend settings are dynamic or sensitive and so cannot be statically specified in the configuration file.

### Terraform_remote_state
- Check the alternatives

### Terraform force unlocking

### Check terraform ignore

### Multiple workspaces environments
Create a tfvars file for iam roles and run the command:
```sh
  terraform apply -var-file staging.tfvars
```