resource "docker_volume" "container_volume" {
  count = var.volume_count
  name  = "${var.volume_name}-${count.index}" # index finds the element index for a given value in a list
  lifecycle {
    prevent_destroy = false
  }
  # for backing up the volumes
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir ${path.cwd}/../backup"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
    on_failure = fail
  }
}