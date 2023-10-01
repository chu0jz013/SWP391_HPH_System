# LOCAL CONFIG

module "vars" {
  source   = "../var"
  file_name = var.file_name
}

locals {
  configuration    = module.vars.configuration
  global_variables = module.vars.global_variables
  global_tags      = module.vars.tags
}

variable "file_name" {
  type        = string
  description = "The lab variable file to run"
}

variable "credentials_file_path" {
  # default = "/home/haikn/key.json"
}