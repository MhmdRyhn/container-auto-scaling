locals {
  http = {
    protocol = "HTTP"
    port     = 80
  }
}

locals {
  protocols = {
    http = {
      name = "HTTP"
      port = 80
    }
    https = {
      name = "HTTPS"
      port = 443
    }
  }

  custom_protocol = {
    tcp_http = {
      name = "tcp"
      port = 80
    }
  }
}
