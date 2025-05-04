#------------------------------------------------------------#
#                        Health Check                        #
#------------------------------------------------------------#

resource "google_compute_health_check" "default" {
  name        = "http-ping-9000"
  description = "HTTP health check"

  timeout_sec         = 5
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = "9000"
    request_path = "/ping"
  }

  depends_on = [google_compute_firewall.default]
}

#------------------------------------------------------------#
#                      Backend Service                       #
#------------------------------------------------------------#

resource "google_compute_backend_service" "default" {
  name                  = "${var.prefix}-traefik"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  health_checks         = [google_compute_health_check.default.id]

  dynamic "backend" {
    for_each = toset(var.node_locations)
    content {
      group                 = data.google_compute_network_endpoint_group.default[backend.key].id
      balancing_mode        = "RATE"
      max_rate_per_endpoint = 500
      capacity_scaler       = 1.0
    }
  }
}

#------------------------------------------------------------#
#                          URL Map                           #
#------------------------------------------------------------#

resource "google_compute_url_map" "default" {
  name            = "${var.prefix}-ingress"
  default_service = google_compute_backend_service.default.id
}

#------------------------------------------------------------#
#                     Target HTTP Proxy                      #
#------------------------------------------------------------#

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.prefix}-ingress-http"
  url_map = google_compute_url_map.default.id

  depends_on = [google_compute_url_map.default]
}

#------------------------------------------------------------#
#                      HTTP(S) Frontend                      #
#------------------------------------------------------------#

resource "google_compute_global_forwarding_rule" "http_frontend" {
  name                  = "${var.prefix}-ingress-http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_protocol           = "TCP"
  ip_address            = data.google_compute_global_address.gke_lb_ip.id
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"

  depends_on = [google_compute_target_http_proxy.default]
}
