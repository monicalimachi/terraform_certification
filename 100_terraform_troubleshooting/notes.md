## Terraform troubleshooting
There are four types of errors:

|Language errors | State errors | Core errors | Provider errors |
|----------------|--------------|--------------|-----------------|
|Terraform encounters a syntax error in configuration for the Terraform or HCL Language| Your resources state has changed from expected state in the config file| A bug has occurred with the core library | The provider's API has changed or doesn't work as expected due to emerging edge cases|
|terraform fmt|terraform refresh|TF_LOG Open Github Issue| TF_LOG Open Github Issue|
terraform validate|terraform apply | - | - |
terraform version| terraform -replace flag| - | - |
|Easy to solve | easy to solve | harder to solve| harder to solve|

## Debugging terraform
Can be enable setting TF_LOG_environment variable to:
- TRACE
- DEBUG
- INFO
- WARN
- ERROR
- JSON : output logs at the trace level or higher, and uses a parseable JSON encoding as the formatting.

Logging can be enable separately, takes the same option as TF_LOG:
- TF_LOG_CORE
- TF_LOG_PROVIDER
Choose were you want to log with TF_LOG_PATH

## TF_LOG
Examples:
```bash
TF_LOG=TRACE terraform apply
TF_LOG=TRACE TF_LOG_PATH=./terraform.log terraform apply
```