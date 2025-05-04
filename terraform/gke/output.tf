#------------------------------------------------------------#
#         Output NAT IP address after apply complete         #
#------------------------------------------------------------#

output "nat_ip" {
  description = "NAT IP"
  sensitive   = false
  value       = data.google_compute_address.gke_nat_ip.address
}
