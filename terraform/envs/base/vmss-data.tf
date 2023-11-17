data "template_file" "linux-vm-cloud-init" {
  template = file("./artifacts/vmss-init/azure-user-data.sh")
}