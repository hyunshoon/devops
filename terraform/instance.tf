data "openstack_images_image_v2" "master_image" {
  name        = "Master"
}

######## master 1 ########
# 인스턴스 생성 + master 볼륨 연결
resource "openstack_compute_instance_v2" "master1" {
  name = "k8s-master1"
  key_pair = "project_key"
  flavor_name = "m1.master"
  security_groups = ["project_secgroup"]

  network {
    name = "${openstack_networking_network_v2.network.name}"
  }

  block_device {
    uuid                  = "${data.openstack_images_image_v2.master_image.id}"
    source_type           = "image"
    volume_size           = 20
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

#  block_device {
#    uuid                  = "${openstack_blockstorage_volume_v2.k8s_master.id}"
#    source_type           = "volume"
#    destination_type      = "volume"
#    boot_index            = 0
#    delete_on_termination = false
#  }

}

######## node1 ########
# 인스턴스 생성 + node 볼륨 연결
resource "openstack_compute_instance_v2" "node1" {
  name = "k8s-node1"
  key_pair = "project_key"
  flavor_name = "m1.node"
  image_name = "Worker"
  security_groups = ["project_secgroup"]

  network {
    name = "${openstack_networking_network_v2.network.name}"
  }
}


# extnet-network pool 에서 ip 올리기
resource "openstack_compute_floatingip_v2" "floating" {
  count = 5
  pool = "extnet-network"
  depends_on = [ openstack_networking_router_interface_v2.interface ]
}

# floating ip - instance 연결
resource "openstack_compute_floatingip_associate_v2" "extip" {
  floating_ip = openstack_compute_floatingip_v2.floating[0].address
  instance_id = openstack_compute_instance_v2.master1.id
}

# floating ip - instance 연결
resource "openstack_compute_floatingip_associate_v2" "extip1" {
  floating_ip = openstack_compute_floatingip_v2.floating[1].address
  instance_id = openstack_compute_instance_v2.node1.id
}

