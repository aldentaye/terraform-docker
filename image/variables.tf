# this references the variable in module block of root main.tf and
# the main.tf of image module references this 
variable "image_in" {
  description = "name of image"
}