terraform {
required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack" 
      version = "~> 1.42.0"
    }
  }
}

# 오픈스택 프로바이더 구성하기
provider "openstack" {
  tenant_name = "admin"
  user_name = "admin"
  password = "test123"
  auth_url = "http://211.183.3.160:5000"
  region = "RegionOne"
}
