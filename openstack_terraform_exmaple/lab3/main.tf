resource "openstack_compute_instance_v2" "instance" {
  name = "instance-${count.index}"
  image_name = var.instance["image_name"]
  flavor_name = var.flavor["name"]
  key_pair = var.keypair["name"]
  security_groups = ["icmp", "webssh"]
  count = var.instance["count"]
  
  network {
    name = var.inside["name"]
  }
}

resource "openstack_compute_instance_v2" "control" {
  name                  = "control"
  image_name            = var.instance["image_name"]
  flavor_name           = var.flavor["name"]
  key_pair              = var.keypair["name"]
  security_groups       = ["webssh", "icmp"]

  network {
    name = var.inside["name"]
  }

  provisioner "file" {
    source = "/root/lab3/terraformkey.pem"
    destination = "/home/centos/.ssh/id_rsa"

    connection {
      type              = "ssh"
      user              = "centos"
      private_key       = file("/root/lab3/terraformkey.pem")
      host              = "${openstack_networking_floatingip_v2.fip2.address}"
    }
  }
}

