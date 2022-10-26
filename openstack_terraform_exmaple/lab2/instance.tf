############# floating ip #################
resource "openstack_networking_floatingip_v2" "fip" {
  pool = "extnet"
  count = 2
}

resource "openstack_compute_floatingip_associate_v2" "fip" {
  floating_ip   = "${openstack_networking_floatingip_v2.fip[count.index].address}"
  instance_id   = "${openstack_compute_instance_v2.instance01[count.index].id}"
  fixed_ip      = "${openstack_compute_instance_v2.instance01[count.index].network.0.fixed_ip_v4}"
  count = 2
}

# security group creation
resource "openstack_compute_secgroup_v2" "thttpssh" {
  name = "ohttpssh"
  description = "permit http, ssh traffic"
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
}


resource "openstack_compute_instance_v2" "instance01" {
  name = "instance-${count.index+1}"
  #image_id = "98394b69-2e4f-4765-ada9-139f30d7a90b"
  image_name = "CentOS7"
  flavor_id = "2"
  key_pair = "terraformkey"
  security_groups = ["ohttpssh", "icmp"]
  user_data = file("first-boot.sh")  
  count = 2
  metadata = { service = "web" }
  
  network {
    name = "private1"
  }
}

output "private_address" {
  value = "${openstack_compute_instance_v2.instance01[*].network.0.fixed_ip_v4}" 
}

output "public_address" {
  value = "${openstack_compute_floatingip_associate_v2.fip[*].floating_ip}" 
}



