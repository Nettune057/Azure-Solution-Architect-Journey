variable "log_analytics_workspace_name" {
  default = "log-analytics"
}

variable "retention_in_days" {
  default = 30
}

variable "log_analytics_sku" {
  default = "PerGB2018"
}

variable "appgw-user-identity" {
  default = "appgw-user-identity"
}

variable "app_gateway_name" {
  default = "AppGw"
}

variable "AppGw-sku" {
  type = map
  default = {
    name = "WAF_v2"
    tier = "WAF_v2"
  }
}

variable "backend_address_pools_name" {
  default = "backend-pool"
}

variable "backend_http_settings_name" {
  default = "d1-base-appgw-backend-setting"
}

variable "cookie_based_affinity" {
  default = "Disabled"
}

variable "path" {
  default = "/"
}

variable "enable_https" {
  default = false
}

variable "request_timeout" {
  default = 30
}

variable "connection_draining_enable_connection_draining" {
  default = true
}

variable "drain_timeout_sec" {
  default = 300
}

variable "http_listener_name" {
  default = "http-listener"
}

variable "https_listener_name" {
  default = "https-listener"
}

variable "ssl_cert_name" {
  default = "appgw-cert"
}

variable "host_name" {
  default = null
}

variable "request_routing_rules_http_priority" {
  default = 100
}

variable "request_routing_rules_rule_type" {
  default = "Basic"
}

variable "redirect_config_https_name" {
  default = "redirect-config-https"
}

variable "request_routing_rules_http_name" {
  default = "http_rules"
}

variable "redirect_configuration_redirect_type" {
  default = "Permanent"
}

variable "request_routing_rules_https_priority" {
  default = 101
}

variable "request_routing_rules_https_name" {
  default = "https-rules"
}

variable "firewall_mode" {
  default = "Prevention"
}

variable "exclusion" {
  default = [
    {
      match_variable          = "RequestCookieNames"
      selector                = "SomeCookie"
      selector_match_operator = "Equals"
    },
    {
      match_variable          = "RequestHeaderNames"
      selector                = "referer"
      selector_match_operator = "Equals"
    }
  ]
}

variable "disabled_rule_group" {
  default = [
    {
      rule_group_name = "REQUEST-930-APPLICATION-ATTACK-LFI"
      rules           = ["930100", "930110"]
    },
    {
      rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
      rules           = ["920160"]
    }
  ]
}

variable "rule_set_version" {
  default = "3.1"
}

variable "file_upload_limit_mb" {
  default = 100
}

variable "max_request_body_size_kb" {
  default = 128
}