# aws events list-targets-by-rule --rule zerorate-hn-system-recovery
# terraform import aws_ssm_association.test-association 5e7006db-a9f8-4819-94d2-65744f453119

# aws_ssm_association.test-association will be destroyed
resource "aws_ssm_association" "test-association" {
  apply_only_at_cron_interval = false
  association_name            = "Ansible-${var.aplicationname}-${var.environment}-asg"
  compliance_severity         = "CRITICAL"
  #document_version            = "$DEFAULT"
  name = "AWS-ApplyAnsiblePlaybooks"
  parameters = {
    "Check"               = "False"
    "ExtraVariables"      = "SSM=True"
    "InstallDependencies" = "True"
    "PlaybookFile"        = "${var.aplicationname}-${var.environment}.yml"
    "SourceInfo" = jsonencode(
      {
        path = var.path
      }
    )
    "SourceType"     = "S3"
    "TimeoutSeconds" = var.TimeoutSeconds
    "Verbose"        = "-v"
  }

  output_location {
    s3_bucket_name = var.s3_bucket_name
    s3_key_prefix  = "statemananger/${var.aplicationname}/${var.environment}"
  }

  targets {
    key = var.tag
    values = [
      "${var.target}",
    ]
  }
}
