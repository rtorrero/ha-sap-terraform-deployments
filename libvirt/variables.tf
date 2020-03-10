variable "qemu_uri" {
  description = "URI to connect with the qemu-service."
  default     = "qemu:///system"
}

variable "base_image" {
  description = "Image of the sap hana nodes"
  type        = string
}

variable "storage_pool" {
  description = "libvirt storage pool name for VM disks"
  default     = "default"
}

variable "iprange" {
  description = "IP range of the isolated network"
  default     = "192.168.106.0/24"
}

variable "isolated_network_bridge" {
  description = "A name for the isolated virtual network bridge device. It must be no longer than 15 characters. Leave empty to have it auto-generated by libvirt."
  type        = string
  default     = ""
}

variable "hana_inst_media" {
  description = "URL of the NFS share where the SAP HANA software installer is stored. This media shall be mounted in `hana_inst_folder`"
  type        = string
}

variable "hana_inst_folder" {
  description = "Folder where SAP HANA installation files are stored"
  type        = string
  default     = "/root/hana_inst_media"
}

variable "hana_fstype" {
  description = "Filesystem type to use for HANA"
  type        = string
  default     = "xfs"
}

variable "netweaver_inst_media" {
  description = "URL of the NFS share where the SAP Netweaver software installer is stored. This media shall be mounted in `/root/netweaver_inst_media`"
  type        = string
  default     = ""
}

variable "netweaver_nfs_share" {
  description = "URL of the NFS share where /sapmnt and /usr/sap/{sid}/SYS will be mounted. This folder must have the sapmnt and usrsapsys folders"
  type        = string
  default     = ""
}

variable "host_ips" {
  description = "IP addresses of the hana nodes"
  type        = list(string)
  default     = ["192.168.106.15", "192.168.106.16"]
}

variable "nw_ips" {
  description = "IP addresses of the netweaver nodes"
  type        = list(string)
  default     = ["192.168.106.17", "192.168.106.18", "192.168.106.19", "192.168.106.20"]
}

variable "nw_virtual_ips" {
  description = "IP addresses of the netweaver nodes"
  type        = list(string)
  default     = ["192.168.106.30", "192.168.106.31", "192.168.106.32", "192.168.106.33"]
}

variable "shared_storage_type" {
  description = "used shared storage type for fencing (sbd). Available options: iscsi, shared-disk."
  type        = string
  default     = "iscsi"
}

variable "drbd_shared_storage_type" {
  description = "used shared storage type for fencing (sbd) for DRBD cluster. Available options: iscsi, shared-disk."
  type        = string
  default     = "iscsi"
}

variable "iscsi_image" {
  description = "iscsi server base image (only used if shared_storage_type is iscsi)"
  type        = string
  default     = ""
}

variable "iscsi_srv_ip" {
  description = "iscsi server address (only used if shared_storage_type is iscsi)"
  type        = string
  default     = "192.168.106.21"
}

variable "iscsi_disks" {
  description = "number of partitions attach to iscsi server. 0 means `all`."
  default     = 0
}

variable "monitoring_srv_ip" {
  description = "monitoring server address"
  type        = string
  default     = "192.168.106.22"
}

variable "monitoring_image" {
  description = "monitoring server base image (if not set, the same image as the hana nodes will be used)"
  type        = string
  default     = ""
}

variable "drbd_ips" {
  description = "IP addresses of the drbd nodes"
  type        = list(string)
  default     = ["192.168.106.23", "192.168.106.24"]
}

variable "reg_code" {
  description = "If informed, register the product using SUSEConnect"
  default     = ""
}

variable "reg_email" {
  description = "Email used for the registration"
  default     = ""
}

# The module format must follow SUSEConnect convention:
# <module_name>/<product_version>/<architecture>
# Example: Suggested modules for SLES for SAP 15
# - sle-module-basesystem/15/x86_64
# - sle-module-desktop-applications/15/x86_64
# - sle-module-server-applications/15/x86_64
# - sle-ha/15/x86_64 (Need the same regcode as SLES for SAP)
# - sle-module-sap-applications/15/x86_64
variable "reg_additional_modules" {
  description = "Map of the modules to be registered. Module name = Regcode, when needed."
  type        = map(string)
  default     = {}
}

# Repository url used to install HA/SAP deployment packages"
# The latest RPM packages can be found at:
# https://download.opensuse.org/repositories/network:/ha-clustering:/Factory/{YOUR OS VERSION}
# Contains the salt formulas rpm packages.
variable "ha_sap_deployment_repo" {
  description = "Repository url used to install HA/SAP deployment packages. If SLE version is not set, the deployment will automatically detect the current OS version"
  type        = string
}

variable "devel_mode" {
  description = "whether or not to install HA/SAP packages from ha_sap_deployment_repo"
  default     = false
}

variable "scenario_type" {
  description = "Deployed scenario type. Available options: performance-optimized, cost-optimized"
  default     = "performance-optimized"
}

variable "provisioner" {
  description = "Used provisioner option. Available options: salt. Let empty to not use any provisioner"
  default     = "salt"
}

variable "background" {
  description = "Run the provisioner execution in background if set to true finishing terraform execution"
  default     = false
}

variable "monitoring_enabled" {
  description = "enable the host to be monitored by exporters, e.g node_exporter"
  default     = false
}

variable "netweaver_enabled" {
  description = "enable SAP Netweaver deployment"
  default     = false
}

variable "drbd_enabled" {
  description = "enable the DRBD cluster for nfs"
  default     = false
}

variable "drbd_count" {
  description = "number of DRBD hosts for cluster"
  default     = 2
}

variable "qa_mode" {
  description = "define qa mode (Disable extra packages outside images)"
  default     = false
}

variable "hwcct" {
  description = "Execute HANA Hardware Configuration Check Tool to bench filesystems"
  type        = bool
  default     = false
}
