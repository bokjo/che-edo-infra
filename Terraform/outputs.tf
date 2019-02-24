output "loadbalancer_id" {
  value = "${azurerm_lb.lb.id}"
}

output "hostname" {
  value = "${var.hostname}"
}

# output "EDO STAGING URL" {
#   value = "${formatlist("EDO_STAGING_URL=%v", azurerm_public_ip.edoip.fqdn)}"
# }
