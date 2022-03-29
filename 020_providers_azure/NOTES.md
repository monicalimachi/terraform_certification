# Install azure-cli in Ubuntu hirsute 21.04
```bash
apt-get update
apt-get install ca-certificates curl apt-transport-https lsb-release gnupg --yes

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ hirsute main" |
    tee /etc/apt/sources.list.d/azure-cli.list

apt-get update
apt-get install azure-cli --yes

az --version
``` 
- Review configuration azure cli: https://pypi.org/project/azure-cli/

- Ubuntu: Create a VM on azure using modules: https://registry.terraform.io/modules/Azure/compute/azurerm/latest

- Verify the virtualMachines and availablity zones on Azure: https://azure.microsoft.com/en-in/global-infrastructure/services/?products=virtual-machines&regions=all
```bash
az vm list-skus --location australiaeast --resource-type virtualMachines --zone --all --output table
```