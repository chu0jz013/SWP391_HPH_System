locals {
  global_variables = {
    # environment = "prod"
    owner   = "haikn2"
    project = "cicd"
  }

  tags = {
    # environment    = "dev"
    owner          = "haikn2"
    project        = "cicd"
    provisioned_by = "terraform"
  }

  prefix_name = "${local.global_variables.owner}-${local.global_variables.project}"
}
