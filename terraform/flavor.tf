
resource "openstack_compute_flavor_v2" "master" {
  name  = "m1.master"
  ram   = "4096"
  vcpus = "1"
  disk  = "15"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "node"{
  name  = "m1.node"
  ram   = "4096"
  vcpus = "1"
  disk  = "10"
  is_public = "true"
}
