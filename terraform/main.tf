terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.48.0"
    }
  }
}

# openstack 이 제공하는 구성
provider "openstack" {
  user_name = "admin"
  tenant_name = "admin"
  password  = "test123"
  auth_url  = "http://211.183.3.99:5000/v3"
}
