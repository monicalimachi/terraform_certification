## State is a particular condition of cloud resources at a specific time
- Terraform preserve state creating the terraform.tfstate file

Some commands to use:
```bash
terraform state list    >   list resources in the state
terraform state mv      >   Move an iten in the state
terraform state pull    >   Pull current remote state and output to stdout
terraform state push    >   Push local state to remote | Update remote state from local state
terraform state replace-provider >   Replace provider in the state
terraform state rm      >   Remove an item from the state | Remove instances from the state
terraform state show    >   Show the state | Show a resource in the state   
terraform state show-module >   Show the state of a module
terraform state show-resource >   Show the state of a resource
terraform state show-resource-provider >   Show the state of a resource provider
terraform state show-resource-provider-config >   Show the state of a resource provider config
terraform state show-resource-provider-meta >   Show the state of a resource provider meta
terraform state show-resource-provider-schema >   Show the state of a resource provider schema
terraform state show-resource-provider-version >   Show the state of a resource provider version
terraform state show-resource-schema >   Show the state of a resource schema
terraform state show-resource-state >   Show the state of a resource state
terraform state show-state >   Show the state
terraform state show-terraform-backend >   Show the state of a terraform backend
terraform state show-var >   Show the state of a variable
terraform state show-vars >   Show the state of variables
terraform state show-workspace >   Show the state of a workspace
terraform state sync    >   Sync local state with remote state
terraform state validate >   Validate the state
terraform state write   >   Write the state
terraform state write-backend >   Write the state to a terraform backend
terraform state write-state >   Write the state to a file
terraform state write-state-file >   Write the state to a file
terraform state write-tfstate >   Write the state to a file
terraform state write-to-backend >   Write the state to a terraform backend
terraform state write-to-file >   Write the state to a file
terraform state write-to-tfstate >   Write the state to a file
terraform state apply   >   Apply the state
terraform state destroy >   Destroy the state
terraform state get     >   Get the state
terraform state list    >   List the state
terraform state backup  >   Backup the state
terraform state restore >   Restore the state
```

## 1. Terraform state mv ALLOWS YOU TO:
- rename existing resources
- move a resource into a different module
- move a module into a different module
* Avoiding create and destroy actions

## EXamples: 
- Resource rename
```bash
terraform state mv packet_device.worker packet_device.helper
```
- Move resource into module
```bash
terraform state mv packet_device.worker module.worker.packet_device.worker
```
- Move module into a module
```bash
terraform state mv module.app module.parent.module.app
```
## 2. Terraform state backup
- All terraform state subcommands that modify state will write a backup file.
- The backup file is named terraform.tfstate.backup. Takes a backup of the current state.

