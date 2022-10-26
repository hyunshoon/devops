output "private_address" {
  value = "${openstack_compute_instance_v2.instance[*].network.0.fixed_ip_v4}"
}

output "public_address" {
  value = "${openstack_compute_floatingip_associate_v2.fip1[*].floating_ip}"
}
output "public_address_control" {
  value = "${openstack_compute_floatingip_associate_v2.fip2.floating_ip}"
}
