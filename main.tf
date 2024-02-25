variable "vm_template_name" {
    type = string 
}

variable "proxmox_node" {
    type = string
}

variable "ssh_key" {
  type = string 
  sensitive = true
}

resource "proxmox_vm_qemu" "mule" {
  count = 2
  name = "mule0${count.index + 1}"
  target_node = var.proxmox_node
  clone = var.vm_template_name
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "48G"
    type = "scsi"
    storage = "vmstor"
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=10.10.10.10${count.index + 1}/24,gw=10.10.10.1"
  nameserver = "8.8.8.8"
  
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF

}
