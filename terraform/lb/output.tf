#------------------------------------------------------------#
#    Output load balance IP address after apply complete     #
#------------------------------------------------------------#

output "lb_ip" {
  description = "LB IP"
  sensitive   = false
  value       = data.google_compute_global_address.gke_lb_ip.address
}
