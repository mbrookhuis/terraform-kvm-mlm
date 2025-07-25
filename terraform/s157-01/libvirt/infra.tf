resource "libvirt_network" "mb-nat_network" {
  name = "mb-nat"
  mode = "nat" 
  domain = "mb.int"
  autostart = true
  addresses = ["192.168.200.0/24"]
  dhcp {
    enabled = true
  }
}

resource "libvirt_network" "mb-int1_network" {
  name = "mb-int1"
  mode = "none"  
  domain = "mb.int"
  addresses = ["192.168.201.0/24"]
  autostart = true
  dhcp {
    enabled = true
  }
}

resource "libvirt_pool" "pool1" {
  name = "pool1"
  type = "dir"
  target {
    path = "/kvm/stpool1"
  }
}


# Defining VM Volume
resource "libvirt_volume" "centos7-qcow2" {
  depends_on = [
	  libvirt_pool.pool1
  ]
  name = "centos7.qcow2"
  pool = "default" # List storage pools using virsh pool-list
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  #source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# Define KVM domain to create
resource "libvirt_domain" "centos7" {
  depends_on = [
    libvirt_network.mb-nat_network,
  	libvirt_network.mb-int1_network,
	  libvirt_volume.centos7-qcow2,
  ]
  name   = "centos7"
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "mb-int1"
  }

  disk {
    volume_id = "${libvirt_volume.centos7-qcow2.id}"
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



# MLM Server
resource "libvirt_volume" "mlm_root" {
  depends_on = [
	  libvirt_pool.pool1
  ]
  name = "mlm_root"
  pool = "${var.smlm_server_storage_pool}"
  source = "/work/virt2/iso/SUSE-Manager-Server.x86_64-5.0.4-Qcow-5.0-2025-04.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "mlm_data" {
  depends_on = [
	  libvirt_pool.pool1
  ]
  name = "mlm_data"
  pool = "${var.smlm_server_storage_pool}"
  size = var.smlm_server_data_disk_size
  format = "qcow2"
}

resource "libvirt_volume" "mlm_db" {
  depends_on = [
	libvirt_pool.pool1
  ]
  name = "mlm_db"
  pool = "${var.smlm_server_storage_pool}"
  size = var.smlm_server_database_disk_size
  format = "qcow2"
}

data "template_file" "ignition" {
  template = file("${path.module}/${var.smlm_server_hostname}_config.ign")
}

resource "libvirt_ignition" "ignition_disk" {
  name           = "${var.smlm_server_hostname}.ignition-disk"
  pool             = var.smlm_server_storage_pool
  content          = data.template_file.ignition.rendered
  count            = 1
}

data "template_file" "combustion" {
  template = file("${path.module}/${var.smlm_server_hostname}_combustion")
}

resource "libvirt_combustion" "combustion_disk" {
  name           = "combustion-disk"
  pool           = "pool1"
  content        = data.template_file.combustion.rendered
  count          = 1
}

resource "libvirt_domain" "mlm50" {
  depends_on = [
    libvirt_network.mb-nat_network,
	libvirt_network.mb-int1_network,
	libvirt_volume.mlm_root,
	libvirt_volume.mlm_data,
	libvirt_volume.mlm_db,
    libvirt_combustion.combustion_disk
  ]
  name   = var.smlm_server_hostname
  memory = var.smlm_server_memory
  vcpu   = var.smlm_server_cpu

  network_interface {
    network_name = var.smlm_server_eth0_network
    addresses = [var.smlm_server_eth0_ip]
    hostname = var.smlm_server_hostname
  }

  network_interface {
    network_name = var.smlm_server_eth1_network
    addresses = [var.smlm_server_eth1_ip]
    hostname = var.smlm_server_hostname
  }

  fw_cfg_name = "opt/org.opensuse.combustion/script"
  
  disk {
    volume_id = "${libvirt_volume.mlm_root.id}"
  }

  disk {
    volume_id = "${libvirt_volume.mlm_data.id}"
  }

  disk {
    volume_id = "${libvirt_volume.mlm_db.id}"
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


# Output Server IP
output "ip_mlm_nat" {
  value = "${libvirt_domain.mlm50.network_interface.0.addresses}"
}

output "ip_mlm_int1" {
  value = "${libvirt_domain.mlm50.network_interface.1.addresses}"
}


