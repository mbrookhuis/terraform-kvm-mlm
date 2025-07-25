variable "smlm_server_hostname" {
  type        = string
  description = "hostname of the smlm server"
  default     = "mlm50"
}

variable "smlm_server_storage_pool" {
  type = string
  description = "storage pool to store the qcow disks"
  default = "pool1"
}

variable "smlm_server_eth0_network" {
  type = string
  description = "network name for eth0, access to internet"
  default = "mb-nat"
}

variable "smlm_server_eth0_ip" {
  type = string
  description = "storage pool to store the qcow disks"
  default = "192.168.200.10"
}

variable "smlm_server_eth1_network" {
  type = string
  description = "storage pool to store the qcow disks"
  default = "mb-int1"
}

variable "smlm_server_eth1_ip" {
  type = string
  description = "storage pool to store the qcow disks"
  default = "192.168.201.10"
}

variable "smlm_server_activation_key" {
  type        = string
  description = "SUSE Multi-Linux Manager Server SCC Activation Key"
  default     = "CAB2C834B793E22E"
}

variable "smlm_server_memory" {
  type        = string
  description = "Memory for SMLM Server"
  default     = 10240
}

variable "smlm_server_cpu" {
  type        = string
  description = "#CPU for SMLM Server"
  default     = 4
}







# proxy
variable "smlm_proxy_server_activation_key" {
  type        = string
  description = "SUSE Multi-Linux Manager Proxy SCC Activation Key"
  default     = "CAB2C834B793E22E"
}

variable "smlm_build_server_activation_key" {
  type        = string
  description = "SUSE Multi-Linux Manager Build Server SCC Activation Key"
  default     = "8579E483F8728AAE"
}

# Local variables used to reduce repetition
locals {
  node_username = "ec2-user"
}

variable "scc_email_address" {
  type        = string
  description = "SCC Email Address"
  default     = "michael.brookhuis@suse.com"
}

variable "smlm_server_ca_ssl_password" {
  type        = string
  description = "SMLM CA SSL Password"
  default     = "suse1234"
}

variable "smlm_server_scc_proxy_user" {
  type        = string
  description = "SMLM SCC Proxy User"
  default     = "2a4feb2ff8"
}

variable "smlm_server_scc_proxy_password" {
  type        = string
  description = "SMLM SCC Proxy User Password"
  default     = "a1e5f51521"
}

variable "smlm_server_admin_user" {
  type        = string
  description = "SMLM Admin User"
  default     = "admin"
}

variable "smlm_server_admin_password" {
  type        = string
  description = "SMLM Admin User Password"
  default     = "suse1234"
}

variable "smlm_server_admin_email_address" {
  type        = string
  description = "SMLM Admin User Email Address"
  default     = "michael.brookhuis@suse.com"
}

variable "smlm_server_additional_scc_proxy_user" {
  type        = string
  description = "SMLM SCC Additional Proxy User"
  default     = "6622994"
}

variable "smlm_server_additional_scc_proxy_password" {
  type        = string
  description = "SMLM SCC Additional Proxy User Password"
  default     = "46dad72284"
}

variable "channels" {
  type        = string
  description = "Channels to be replicated"
  default     = "sle-micro-5.5-pool-x86_64 sle-micro-5.5-updates-x86_64 suse-manager-proxy-5.0-pool-x86_64 suse-manager-proxy-5.0-updates-x86_64 sle-manager-tools-for-micro5-pool-x86_64-5.5 sle-manager-tools-for-micro5-updates-x86_64-5.5 sl-micro-6.0-pool-x86_64 sl-micro-extras-6.0-pool-x86_64 suse-manager-tools-for-sl-micro-6.0-x86_64 sl-micro-6.1-pool-x86_64 sl-micro-extras-6.1-pool-x86_64 suse-manager-tools-for-sl-micro-6.1-x86_64 sle-product-sles15-sp6-pool-x86_64 sle-product-sles15-sp6-updates-x86_64 sle-module-basesystem15-sp6-pool-x86_64 sle-module-basesystem15-sp6-updates-x86_64 sle-module-containers15-sp6-pool-x86_64 sle-module-containers15-sp6-updates-x86_64 sle-module-server-applications15-sp6-pool-x86_64 sle-module-server-applications15-sp6-updates-x86_64 sle-module-public-cloud15-sp6-pool-x86_64 sle-module-public-cloud15-sp6-updates-x86_64 sle-module-desktop-applications15-sp6-pool-x86_64 sle-module-desktop-applications15-sp6-updates-x86_64 sle-module-devtools15-sp6-pool-x86_64 sle-module-devtools15-sp6-updates-x86_64 sle-manager-tools15-pool-x86_64-sp6 sle-manager-tools15-updates-x86_64-sp6"
}

variable "projects" {
  type        = map(object({
    name = string
    description = string
    stages = string
    basechannel = string
    additional = string
  }))
  description = "Projects and their channels"
  default = {
    sles15sp6 = {
      name = "sles15sp6"
      description = "sles15sp6"
      stages = "test,prod"
      basechannel = "sle-product-sles15-sp6-pool-x86_64"
      additional = "sle-product-sles15-sp6-updates-x86_64,sle-module-basesystem15-sp6-pool-x86_64,sle-module-basesystem15-sp6-updates-x86_64,sle-module-containers15-sp6-pool-x86_64,sle-module-containers15-sp6-updates-x86_64,sle-module-server-applications15-sp6-pool-x86_64,sle-module-server-applications15-sp6-updates-x86_64,sle-module-public-cloud15-sp6-pool-x86_64,sle-module-public-cloud15-sp6-updates-x86_64,sle-module-desktop-applications15-sp6-pool-x86_64,sle-module-desktop-applications15-sp6-updates-x86_64,sle-module-devtools15-sp6-pool-x86_64,sle-module-devtools15-sp6-updates-x86_64,sle-manager-tools15-pool-x86_64-sp6,sle-manager-tools15-updates-x86_64-sp6"
    }
    slemicro55 = {
      name = "slemicro55"
      description = "slemicro55"
      stages = "test,prod"
      basechannel = "sle-micro-5.5-pool-x86_64"
      additional = "sle-micro-5.5-updates-x86_64,suse-manager-proxy-5.0-pool-x86_64,suse-manager-proxy-5.0-updates-x86_64,sle-manager-tools-for-micro5-pool-x86_64-5.5,sle-manager-tools-for-micro5-updates-x86_64-5.5"
    }
    slmicro60 = {
      name = "slmicro60"
      description = "slmicro60"
      stages = "test,prod"
      basechannel = "sl-micro-6.0-pool-x86_64"
      additional = "suse-manager-tools-for-sl-micro-6.0-x86_64,sl-micro-extras-6.0-pool-x86_64"
    }
    slmicro61 = {
      name = "slmicro61"
      description = "slmicro61"
      stages = "test,prod"
      basechannel = "sl-micro-6.1-pool-x86_64"
      additional = "suse-manager-tools-for-sl-micro-6.1-x86_64,sl-micro-extras-6.1-pool-x86_64"
    }
  }
}

variable "activationkeys" {
  type        = map(object({
    name = string
    description = string
    channelprefix = string
    basechannel = string
    additional = string
    entitlements = string
  }))
  description = "Activation Keys and their channels"
  default = {
    sles15sp6-build-test = {
      name = "sles15sp6-build-test"
      description = "sles15sp6-build-test"
      channelprefix = "sles15sp6-test"
      basechannel = "sle-product-sles15-sp6-pool-x86_64"
      additional = "sle-product-sles15-sp6-updates-x86_64,sle-module-basesystem15-sp6-pool-x86_64,sle-module-basesystem15-sp6-updates-x86_64,sle-module-containers15-sp6-pool-x86_64,sle-module-containers15-sp6-updates-x86_64,sle-module-server-applications15-sp6-pool-x86_64,sle-module-server-applications15-sp6-updates-x86_64,sle-module-public-cloud15-sp6-pool-x86_64,sle-module-public-cloud15-sp6-updates-x86_64,sle-module-desktop-applications15-sp6-pool-x86_64,sle-module-desktop-applications15-sp6-updates-x86_64,sle-module-devtools15-sp6-pool-x86_64,sle-module-devtools15-sp6-updates-x86_64,sle-manager-tools15-pool-x86_64-sp6,sle-manager-tools15-updates-x86_64-sp6"
      entitlements = "container_build_host osimage_build_host"
    }
    sles15sp6-build-prod = {
      name = "sles15sp6-build-prod"
      description = "sles15sp6-build-prod"
      channelprefix = "sles15sp6-prod"
      basechannel = "sle-product-sles15-sp6-pool-x86_64"
      additional = "sle-product-sles15-sp6-updates-x86_64,sle-module-basesystem15-sp6-pool-x86_64,sle-module-basesystem15-sp6-updates-x86_64,sle-module-containers15-sp6-pool-x86_64,sle-module-containers15-sp6-updates-x86_64,sle-module-server-applications15-sp6-pool-x86_64,sle-module-server-applications15-sp6-updates-x86_64,sle-module-public-cloud15-sp6-pool-x86_64,sle-module-public-cloud15-sp6-updates-x86_64,sle-module-desktop-applications15-sp6-pool-x86_64,sle-module-desktop-applications15-sp6-updates-x86_64,sle-module-devtools15-sp6-pool-x86_64,sle-module-devtools15-sp6-updates-x86_64,sle-manager-tools15-pool-x86_64-sp6,sle-manager-tools15-updates-x86_64-sp6"
      entitlements = "container_build_host osimage_build_host"
    }
    slemicro55-test = {
      name = "slemicro55-test"
      description = "slemicro55-test"
      channelprefix = "slemicro55-test"
      basechannel = "sle-micro-5.5-pool-x86_64"
      additional = "sle-micro-5.5-updates-x86_64,suse-manager-proxy-5.0-pool-x86_64,suse-manager-proxy-5.0-updates-x86_64,sle-manager-tools-for-micro5-pool-x86_64-5.5,sle-manager-tools-for-micro5-updates-x86_64-5.5"
      entitlements = ""
    }
    slemicro55-prod = {
      name = "slemicro55-prod"
      description = "slemicro55-prod"
      channelprefix = "slemicro55-prod"
      basechannel = "sle-micro-5.5-pool-x86_64"
      additional = "sle-micro-5.5-updates-x86_64,suse-manager-proxy-5.0-pool-x86_64,suse-manager-proxy-5.0-updates-x86_64,sle-manager-tools-for-micro5-pool-x86_64-5.5,sle-manager-tools-for-micro5-updates-x86_64-5.5"
      entitlements = ""
    }
    slmicro60-test = {
      name = "slmicro60-test"
      description = "slmicro60-test"
      channelprefix = "slmicro60-test"
      basechannel = "sl-micro-6.0-pool-x86_64"
      additional = "suse-manager-tools-for-sl-micro-6.0-x86_64,sl-micro-extras-6.0-pool-x86_64"
      entitlements = ""
    }
    slmicro60-prod = {
      name = "slmicro60-prod"
      description = "slmicro60-prod"
      channelprefix = "slmicro60-prod"
      basechannel = "sl-micro-6.0-pool-x86_64"
      additional = "suse-manager-tools-for-sl-micro-6.0-x86_64,sl-micro-extras-6.0-pool-x86_64"
      entitlements = ""
    }
    slmicro61-test = {
      name = "slmicro61-test"
      description = "slmicro61-test"
      channelprefix = "slmicro61-test"
      basechannel = "sl-micro-6.1-pool-x86_64"
      additional = "suse-manager-tools-for-sl-micro-6.1-x86_64,sl-micro-extras-6.1-pool-x86_64"
      entitlements = ""
    }
    slmicro61-prod = {
      name = "slmicro61-prod"
      description = "slmicro61-prod"
      channelprefix = "slmicro61-prod"
      basechannel = "sl-micro-6.1-pool-x86_64"
      additional = "suse-manager-tools-for-sl-micro-6.1-x86_64,sl-micro-extras-6.1-pool-x86_64"
      entitlements = ""
    }
  }
}

variable "distributions" {
  type        = map(object({
    name = string
    description = string
    path = string
    stages = string
    basechannel = string
  }))
  description = "Distributions to create"
  default = {
    sles15sp6 = {
      name = "sles15sp6"
      description = "sles15sp6"
      path = "/srv/www/htdocs/pub/isos/sles15sp6"
      basechannel = "sle-product-sles15-sp6-pool-x86_64"
      stages = "test,prod"
    }
    slemicro55 = {
      name = "slemicro55"
      description = "slemicro55"
      path = "/srv/www/htdocs/pub/isos/slemicro55"
      basechannel = "sle-micro-5.5-pool-x86_64"
      stages = "test,prod"
    }
    slmicro60 = {
      name = "slmicro60"
      description = "slmicro60"
      path = "/srv/www/htdocs/pub/isos/slmicro60"
      basechannel = "sl-micro-6.0-pool-x86_64"
      stages = "test,prod"
    }
    slmicro61 = {
      name = "slmicro61"
      description = "slmicro61"
      path = "/srv/www/htdocs/pub/isos/slmicro61"
      basechannel = "sl-micro-6.1-pool-x86_64"
      stages = "test,prod"
    }
  }
}

variable "smlm_proxy_server_data_device" {
  type        = string
  description = "SUSE Multi-Linux Manager Proxy Data Device"
  default     = "/dev/nvme1n1"
}

variable "smlm_proxy_smlm_activation_key" {
  type        = string
  description = "SUSE Multi-Linux Proxy SMLM activation key"
  default     = "1-slemicro55-prod"
}

variable "smlm_proxy_server_data_disk_size" {
  type        = string
  description = "SMLM Proxy Server Data Disk Size in GB"
  default     = "100"
}

variable "smlm_proxy_server_cache_size" {
  type        = string
  description = "SMLM Proxy Server Cache Size in MB"
  default     = "61440"
}

variable "smlm_build_server_smlm_activation_key" {
  type        = string
  description = "SUSE Multi-Linux Manager Build Server SMLM Activation Key"
  default     = "1-sles15sp6-build-prod"
}

variable "smlm_server_data_disk_size" {
  type        = string
  description = "SMLM Server Data Disk Size in B - size must be different than database disk!"
  default     = 1024 * 1024 * 1024 * 150
}

variable "smlm_server_database_disk_size" {
  type        = string
  description = "SMLM Server Data Disk Size in B - size must be different than data disk!"
  default     = 1024 * 1024 * 1024 * 50
}

variable "image_profiles" {
  type        = map(object({
    label = string
    description = string
    type = string
    store_label = string
    activation_key = string
    kiwi_path = string
    kiwi_options = string
  }))
  description = "Image Profiles to create"
  default = {
    slmicro60-test = {
      label = "slmicro60-test"
      description = "slmicro60-test"
      type = "kiwi"
      store_label = "SUSE Manager OS Image Store"
      activation_key = "1-slmicro60-test"
      kiwi_path = "https://humble-dev%2B1-at-058264500843:%2FhZ%2FDLA5NTMY7ACihQLt%2BCXTDye7I5Pb%2Bwb9FJk%2Bo9gRqOmv2whckFxyteg%3D@git-codecommit.eu-central-1.amazonaws.com/v1/repos/kop-prototype-suse#main:kiwi-image-micro-60"
      kiwi_options = "--profile x86-self_install"
    }
    slmicro60-prod = {
      label = "slmicro60-prod"
      description = "slmicro60-prod"
      type = "kiwi"
      store_label = "SUSE Manager OS Image Store"
      activation_key = "1-slmicro60-prod"
      kiwi_path = "https://humble-dev%2B1-at-058264500843:%2FhZ%2FDLA5NTMY7ACihQLt%2BCXTDye7I5Pb%2Bwb9FJk%2Bo9gRqOmv2whckFxyteg%3D@git-codecommit.eu-central-1.amazonaws.com/v1/repos/kop-prototype-suse#main:kiwi-image-micro-60"
      kiwi_options = "--profile x86-self_install"
    }
    slmicro61-test = {
      label = "slmicro61-test"
      description = "slmicro61-test"
      type = "kiwi"
      store_label = "SUSE Manager OS Image Store"
      activation_key = "1-slmicro61-test"
      kiwi_path = "https://humble-dev%2B1-at-058264500843:%2FhZ%2FDLA5NTMY7ACihQLt%2BCXTDye7I5Pb%2Bwb9FJk%2Bo9gRqOmv2whckFxyteg%3D@git-codecommit.eu-central-1.amazonaws.com/v1/repos/kop-prototype-suse#main:kiwi-image-micro-60"
      kiwi_options = "--profile x86-self_install"
    }
    slmicro61-prod = {
      label = "slmicro61-prod"
      description = "slmicro61-prod"
      type = "kiwi"
      store_label = "SUSE Manager OS Image Store"
      activation_key = "1-slmicro61-prod"
      kiwi_path = "https://humble-dev%2B1-at-058264500843:%2FhZ%2FDLA5NTMY7ACihQLt%2BCXTDye7I5Pb%2Bwb9FJk%2Bo9gRqOmv2whckFxyteg%3D@git-codecommit.eu-central-1.amazonaws.com/v1/repos/kop-prototype-suse#main:kiwi-image-micro-60"
      kiwi_options = "--profile x86-self_install"
    }
  }
}

variable "smlm_server_version" {
  type = string
  default = "5.0.4"
}

variable "smlm_proxy_server_version" {
  type = string
  default = "5.0.4"
}

variable "smlm_proxies" {
  type        = map(object({
    name = string
    aws_region = string
    aws_zone = string
    count = number
  }))
  description = "Number of SLML Proxy Servers per region and zone"
  default = {
    #    eu-central-1b = {
    #     name = "eu-central-1"
    #     aws_region = "eu-central-1"
    #      aws_zone = "eu-central-1b"
    #      count = 1
    #    }
    #    euw1-az1 = {
    #      name = "eu-west-1"
    #      aws_region = "eu-west-1"
    #      aws_zone = "euw1-az1"
    #      count = 1
    #    }
    eu-central-1a = {
      name = "eu-central-1"
      aws_region = "eu-central-1"
      aws_zone = "eu-central-1a"
      count = 2
    }
  }
}

variable "dns_zone" {
  type = string
  default = "krones.giebert.dev"
  # for later:
  # kop.share2act-dev.io
  # kop.share2act-test.io
  # kop.share2act.io
}
