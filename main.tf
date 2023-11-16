module "image" {
  source   = "./image"
  for_each = local.deployment
  
  image_in = each.value.image # gets each image in locals file
}

module "container" {
  source   = "./container" # where the container module exists
  for_each = local.deployment # iterating over the local deployment, like a variable but different
  
  # the in variables because we bring these ~in~ for use later within the modules
  count_in          = each.value.container_count
  name_in           = each.key
  image_in          = module.image[each.key].image_out # this is from the output
  int_port_in       = each.value.int
  ext_port_in       = each.value.ext 
  volumes_in        = each.value.volumes # iterate through volumes provided in locals.tf
}