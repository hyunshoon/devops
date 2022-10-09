
# 사설네트워크
resource "openstack_networking_network_v2" "network" {
  name = "project-network"
  admin_state_up = "true"
  shared = "false"
}

# 사설네트워크 서브넷
resource "openstack_networking_subnet_v2" "subnet" {
  name = "project-subnet"
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr = "172.16.1.0/24"
  dns_nameservers = ["8.8.8.8"]
}

# 외부네트워크
resource "openstack_networking_network_v2" "network2" {
  name = "extnet-network"
  admin_state_up = "true"
  shared = "false"
  external       = "true"
  segments {
    physical_network = "extnet"
    network_type     = "flat"
  }
}

# 외부네트워크 서브넷
resource "openstack_networking_subnet_v2" "subnet2" {
  name = "extnet-subnet"
  tenant_id = "project_test"
  network_id = "${openstack_networking_network_v2.network2.id}"
  cidr = "211.183.3.0/24"
  enable_dhcp = "false"
  gateway_ip = "211.183.3.2"
  dns_nameservers = ["8.8.8.8"]
  allocation_pool {
    start = "211.183.3.200"
    end = "211.183.3.220"
  }
  ip_version = 4
}

# 라우터
resource "openstack_networking_router_v2" "router" {
  name = "project-router"
  admin_state_up = "true"
  external_network_id = "${openstack_networking_network_v2.network2.id}"
}

# 라우터 인터페이스 연결
resource "openstack_networking_router_interface_v2" "interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}
