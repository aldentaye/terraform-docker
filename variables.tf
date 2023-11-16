# specify the type for each variable and values are in tfvars file
variable "image" {
  type        = map(any)
  description = "Images for containers"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "influxdb:2.0"
      prod = "influxdb:2.0"
    }
    grafana = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }
}

variable "ext_port" {
  type = map(any)
}

variable "int_port" {
  type    = number
  default = 1880
}

# locals {
#   container_count = length(var.ext_port[terraform.workspace])
# }