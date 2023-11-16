resource "random_string" "random" {
  count   = var.count_in # count in is number of containers based on listed port nos in tfvars
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "app_container" {
  count = var.count_in # count comes from local, no of assigned ports
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index] 
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volume_output[volumes.key]
    }
  }
}

module "volume" {
  source = "./volume"
  count  = var.count_in

  volume_count = length(var.volumes_in) # number of volumes that will be created
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}