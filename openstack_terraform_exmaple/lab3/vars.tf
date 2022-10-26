variable "instance" {
  default = {
    image_name = "CentOS7"
    image_id = "98394b69-2e4f-4765-ada9-139f30d7a90b"
    count = 3
  }
}

variable "inside" {
  default = {
    name = "private1"
    id = "ab0bc22b-f90b-49a2-8182-9a458101620f"
  }
}

variable "outside" {
  default = {
    name = "extnet"
    id = "98facebd-53fc-4a1c-80be-013026471da4"
  }
}

variable "flavor" {
  default = {
    id = "6"
    name = "m1.sm"
  }
}
variable "keypair" {
  default = {
    name        = "terraformkey"
  }
}
