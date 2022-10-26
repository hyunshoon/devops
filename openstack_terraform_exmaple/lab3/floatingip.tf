resource "openstack_networking_floatingip_v2" "fip1" {
  pool = var.outside["name"]
  count = var.instance["count"]
}

resource "openstack_compute_floatingip_associate_v2" "fip1" {
  count         = var.instance["count"]
  floating_ip   = "${openstack_networking_floatingip_v2.fip1[count.index].address}"
  instance_id   = "${openstack_compute_instance_v2.instance[count.index].id}"
}

resource "openstack_networking_floatingip_v2" "fip2" {
  pool = var.outside["name"]
}

resource "openstack_compute_floatingip_associate_v2" "fip2" {
  floating_ip   = "${openstack_networking_floatingip_v2.fip2.address}"
  instance_id   = "${openstack_compute_instance_v2.control.id}"
  fixed_ip      = "${openstack_compute_instance_v2.control.network.0.fixed_ip_v4}"
}
