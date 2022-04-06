# terraform plan

Creates an execution plan, it consists:
- Reading the current state of any already-existing remote objects to make sure that the terraform state is up-to-date.
- Comparing the current configuration to the prior state and noting any differences.
- Proposing a set of change actions that should, if applied, make the remote objects match the configuration.
- Terraform plan does not carry out proposed changed (it's terraform apply task)
- Terraform plan file is binary file, it's machine code

Speculative Plans                           |   Saved Plans
Running terraform apply                     |   terraform apply -out=FILE    

Terraform will output the description of    |   generate a saved plan file, it can then pass along
the effect of the plan but without any      |   to the terraform apply. eg terraform apply FILE
intent to actually apply it                 |   It will not asked manually approve the plan, it works       
                                            |   like auto-approve


# terraform apply
Command executes the actions proposed in an execution plan

Automatic Plan Mode                         |   Saved Plan Mode

when you run terraform apply                |   Provide a filename to teraform to saved plan file
Executes plan, validate and the apply       |   terraform apply FILE

Requires to manually approve the plan by    |   Performs exactly the steps specified by that plan file.
writing "yes"                               |   It doesn't prompt for approval.

Terraform apply -auto-approve flag will     |   Inspect a file before applying: terraform show
automatically approve the plan              | 


