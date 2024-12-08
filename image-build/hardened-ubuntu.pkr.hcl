packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
  sensitive = true
}
variable "tenant_id" {
  type = string
}
variable "subscription_id" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "image_name" {
  type = string
}

variable "location" {
  type = string
}

source "azure-arm" "generated_hardened_image" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
  }
  client_id           = "${var.client_id}"
  client_secret       = "${var.client_secret}"
  tenant_id           = "${var.tenant_id}"
  subscription_id     = "${var.subscription_id}"
  location            = "${var.location}"
  managed_image_name  = "${var.image_name}"
  managed_image_resource_group_name = "${var.resource_group}"

  # Base image details
  os_type            = "Linux"
  image_publisher    = "Canonical"
  image_offer        = "0001-com-ubuntu-server-jammy"
  image_sku          = "22_04-lts"
  vm_size            = "Standard_DS2_v2"
}

build {
  sources = ["source.azure-arm.generated_hardened_image"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      "apt-get update -y",
      "apt-get upgrade -y",
      "systemctl stop waagent",
      "systemctl disable waagent",
      "apt-get remove -y walinuxagent",
      "pt -y purge walinuxagent",
      "cp -rf /var/lib/waagent /var/lib/waagent.bkp",
      "rm -rf /var/lib/waagent",
      "rm -f /var/log/waagent.log"
    ]
    inline_shebang = "/bin/sh -x"
  }

  provisioner "shell" {
    script = "./scripts/harden-machine.sh"
  }
}
