resource "openstack_compute_instance_v2" "eachfor_test" {
  for_each 		= toset(var.instance_name)
  name			= each.value
  image_name		= "CentOS7"
  flavor_name		= "m1.sm"
  key_pair		= "terraformkey"
  security_groups	= ["webssh", "icmp"]
  
  network {
    name = "private1"
  }
}
output "server_name" {
  value = [ for vm in openstack_compute_instance_v2.eachfor_test : upper(vm.name) ]
}
