locals {
  # we iterate over these with for_each in the root main.tf
  deployment = {
    nodered = {
      container_count = length(var.ext_port["nodered"][terraform.workspace]) # the number of ports specified in tfvars
      image = var.image["nodered"][terraform.workspace]
      int = 1880
      ext = var.ext_port["nodered"][terraform.workspace]
      # iterate over these under dynamic for_each under a content block
      volumes = [
        { container_path_each = "/data" }
      ]
    }
    influxdb = {
      container_count = length(var.ext_port["influxdb"][terraform.workspace])
      image = var.image["influxdb"][terraform.workspace]
      int = 8086
      ext = var.ext_port["influxdb"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/influxdb" }
      ]
    }
    grafana = {
      container_count = length(var.ext_port["grafana"][terraform.workspace])
      image           = var.image["grafana"][terraform.workspace]
      int             = 3000
      ext             = var.ext_port["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}