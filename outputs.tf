# output "container_info" {
#   value = flatten(module.container[*].container_info)
#   description= "ID of the container"
# }

output "container_info" {
  value = module.container[*]
}