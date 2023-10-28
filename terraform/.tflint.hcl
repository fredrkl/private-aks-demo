config {
  format = "compact"
  module = true
}

plugin "terraform" {
  # List of rules in the preset: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.0/docs/rules/README.md
  preset = "recommended"
  enabled = true
}
