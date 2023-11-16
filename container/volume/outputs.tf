output "volume_output" {
    # name of every volume created 
    value = docker_volume.container_volume[*].name
}
