#volume define

resource "libvirt_volume" "centos7vol" {
  name = "centos7-1.qcow2"
  pool = "default"
  source = "/cloudimg/centos-base.qcow2"
  format = "qcow2"
}
#instance define

resource "libvirt_domain" "centos7-1" {
  name = "centos7-1"
  memory = "1024"
  vcpu = 1

  network_interface {
    addresses = ["211.183.3.199"]
    #network_name = "default"
    bridge = "br0"
  }

  disk {
    volume_id = "${libvirt_volume.centos7vol.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

# result
output "ip" {
  value = "${libvirt_domain.centos7-1.network_interface.0.addresses.0}"
}
