## Finding Modules
- You can find modules publicly in the [Terraform Registry]
- You can filter based on popular providers
- Or search partial terms eg: azure compute
- Only verified modules will be displayed in search terms

## Using Modules

### Public Modules
- Terraform registry is integrated directly into terraform
- The sintax for specifying a registry module is: <NAMESPACE>/<NAME>/<PROVIDER>
```bash
module "consul"{
    source = "hashicorp/consul/aws"
    version = "1.0.0"
}
```
- Terraform init command will download and cache any modules referenced by a configuration

### Private Modules
- Private registry modules have source string of the form:
<HOSTNAME>/<NAMESPACE>/<NAME>/<PROVIDER>
```bash
module "vpc" {
    source = "app.terraform.io/example_corp/vpc/aws"
    version = "0.9.3"
}
```
- To configure private module access, you need to authneticate against Terraform Cloud via ``terraform login``
- Alternatively you can create a user API Token and manually configure credentials in the CLI config file

## Publishing modules
- Anyone can publish and share modules on the Terraform Registry
Published modules support:
- Versioning
- automatically generate documentation
- allow browsing version histories
- show examples
- READMEs
- Repos names must be in the following format: ``terraform-<PROVIDER>-<NAME>``

Public modules are managed via a public Git repo on Github
- Once a module is registered, to push updates you simply push new versions to properly formed Git Tags (Select the repository)
- You can connet and publish your module in seconds

## Verified Modules
- Verified modules are reviewes by HashiCorp and actively maintained by contributors to stay up-to-date and compatible with both Terraform and their respective providers.
- Verified badge appears next to module name in the registry
- Verified badge is not indicatative of flexibility or feature support, or quality
- very simple modules can be verified just because they're great examples of modules
- unverified module could be extremely high quality and actively maintained
- unverified module shouldn't  be assumed to be poor quality
- unverified means it hasn't benn created by a HashiCorp partner.

## Standard Module structure:
The Standard Module Structure is a file and directory layout recommend for module development
### Primary entry point: Root Module
The required files in the root directory:
- main.tf: the entry point file of your module
- variables.tf: variable that can be passed in
- outputs.tf:outputed values
- README: Describes how the module works
- LICENSE: the license under which this module is available

### Nested Module: are optional must be contained in the modules/ directory
- A submodule that contains a README is consider usable by external users
- A submodule that does not contain a README is considered internal use only
- Avoid using relative paths when sourcing module blocks



