terraform {
  required_version = ">= 1.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.48"
    }
  }
}

provider openstack {
  cloud = "openstack"
  tenant_name = "demo"
}

data "openstack_images_image_v2" "rocky_9" {
  name = "Rocky-9.2"
  most_recent = true
}

data "openstack_compute_flavor_v2" "m1_medium" {
  name = "m1.medium"
}

resource "openstack_compute_instance_v2" "my_instance" {
  name = "my-tf-test"
  flavor_id = data.openstack_compute_flavor_v2.m1_medium.id
  security_groups = ["default"]
  key_pair = "my_key_pair_name"

  block_device {
    uuid = data.openstack_images_image_v2.rocky_9.id
    source_type = "image"
    volume_size = 40
    boot_index = 0
    destination_type = "volume"
    delete_on_termination = true
  }

  network {
    name = "demo-vxlan"
  }
}

resource "openstack_compute_floatingip_v2" "floatip_1" {
  pool = "external"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_compute_floatingip_v2.floatip_1.address
  instance_id = openstack_compute_instance_v2.my_instance.id
}

output "ip" {
 value = openstack_compute_floatingip_v2.floatip_1.address
}
