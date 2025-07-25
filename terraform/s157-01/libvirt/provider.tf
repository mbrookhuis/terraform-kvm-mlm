terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
      }
   }
}

provider "libvirt" {
  uri = "qemu+ssh://root@s157-01.mb.int/system" # Or your specific libvirt URI
}
