terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

variable "pm_api_url" {
  type = string
}

provider "proxmox" {
  pm_api_url = var.pm_api_url
}
