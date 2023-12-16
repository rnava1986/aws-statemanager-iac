# (because aws_ssm_association.test_association is not in configuration)
resource "aws_ssm_association" "test_association" {
  apply_only_at_cron_interval = false
  association_name            = "test_de_prueba"
  compliance_severity         = "UNSPECIFIED"
  document_version            = "$DEFAULT"
  name                        = "AWS-ApplyAnsiblePlaybooks"
  parameters = {
    "Check"               = "False"
    "ExtraVariables"      = "SSM=True"
    "InstallDependencies" = "True"
    "PlaybookFile"        = "hello-world-playbook.yml"
    "SourceInfo" = jsonencode(
      {
        getOptions = "branch:main"
        owner      = "rnava1986"
        repository = "aws-statemanager-iac"
      }
    )
    "SourceType"     = "GitHub"
    "TimeoutSeconds" = "3600"
    "Verbose"        = "-v"
  }

  targets {
    key = "InstanceIds"
    values = [
      "i-xxxxxxx",
    ]
  }
}
