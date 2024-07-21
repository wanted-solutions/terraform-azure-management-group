data "local_file" "metadata" {
  count = (
    var.metadata.module_external_metadata != null
    && var.metadata.module_external_metadata == "local"
  ) ? 1 : 0

  filename = format("%s/foo.", path.module)
}

data "consul_keys" "metadata" {
  count = (
    var.metadata.module_external_metadata != null
    && var.metadata.module_external_metadata == "consul"
  ) ? 1 : 0

  key {
    name    = "ami"
    path    = "service/app/launch_ami"
    default = "ami-1234"
  }
}