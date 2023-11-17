# Azurerm Provider configuration
resource "azurerm_log_analytics_workspace" "example" {
  resource_group_name = local.rg_name
  location            = var.rg_location
  name                = "${local.prefix_name}-${var.log_analytics_workspace_name}"
  retention_in_days   = var.retention_in_days
  sku                 = var.log_analytics_sku

}
resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = local.rg_name
  location            = var.rg_location
  name                = "${local.prefix_name}-${var.appgw-user-identity}"
}

module "application-gateway" {
  source = "../../modules/terraform-azure-appgw-waf"

  public_ip_address_id = module.vnet.appgw_public_ip_address_id
  # By default, this module will not create a resource group and expect to provide
  # a existing RG name to use an existing resource group. Location will be same as existing RG.
  # set the argument to `create_resource_group = true` to create new resource.
  resource_group_name  = local.rg_name
  location             = var.rg_location
  virtual_network_name = module.vnet.virtual_network_name
  subnet_name          = module.vnet.appgw_subnet_name
  app_gateway_name     = "${local.prefix_name}-${var.app_gateway_name}"

  # SKU requires `name`, `tier` to use for this Application Gateway
  # `Capacity` property is optional if `autoscale_configuration` is set
  sku = var.AppGw-sku

  autoscale_configuration = {
    min_capacity = 1
    max_capacity = 15
  }

  # A backend pool routes request to backend servers, which serve the request.
  # Can create different backend pools for different types of requests
  backend_address_pools = [
    {
      name  = "${local.prefix_name}-${var.backend_address_pools_name}"
      fqdns = ["10.0.4.4"]
    }
  ]

  # An application gateway routes traffic to the backend servers using the port, protocol, and other settings
  # The port and protocol used to check traffic is encrypted between the application gateway and backend servers
  # List of backend HTTP settings can be added here.
  # `probe_name` argument is required if you are defing health probes.
  backend_http_settings = [
    {
      name                  = var.backend_http_settings_name
      cookie_based_affinity = var.cookie_based_affinity
      path                  = var.path
      enable_https          = var.enable_https
      request_timeout       = var.request_timeout
      # probe_name            = "appgw-testgateway-westeurope-probe1" # Remove this if `health_probes` object is not defined.
      connection_draining   = {
          enable_connection_draining = var.connection_draining_enable_connection_draining
          drain_timeout_sec          = var.drain_timeout_sec
      }
    }
  ]

  # List of HTTP/HTTPS listeners. SSL Certificate name is required
  # `Basic` - This type of listener listens to a single domain site, where it has a single DNS mapping to the IP address of the
  # application gateway. This listener configuration is required when you host a single site behind an application gateway.
  # `Multi-site` - This listener configuration is required when you want to configure routing based on host name or domain name for
  # more than one web application on the same application gateway. Each website can be directed to its own backend pool.
  # Setting `host_name` value changes Listener Type to 'Multi site`. `host_names` allows special wildcard charcters.
  http_listeners = [
    {
      name                 = "${local.prefix_name}-${var.https_listener_name}"
      ssl_certificate_name = "${local.prefix_name}-${var.ssl_cert_name}"
      host_name            = var.host_name
    },
    {
      name                 = "${local.prefix_name}-${var.http_listener_name}"
      ssl_certificate_name = null
      host_name            = var.host_name
    }
  ]

  # Request routing rule is to determine how to route traffic on the listener.
  # The rule binds the listener, the back-end server pool, and the backend HTTP settings.
  # `Basic` - All requests on the associated listener (for example, blog.contoso.com/*) are forwarded to the associated
  # backend pool by using the associated HTTP setting.
  # `Path-based` - This routing rule lets you route the requests on the associated listener to a specific backend pool,
  # based on the URL in the request.
  request_routing_rules = [
    {
      priority                   = var.request_routing_rules_http_priority
      name                       = "${local.prefix_name}-${var.request_routing_rules_http_name}"
      rule_type                  = var.request_routing_rules_rule_type
      http_listener_name         = "${local.prefix_name}-${var.http_listener_name}"
      redirect_configuration_name = "${local.prefix_name}-${var.redirect_config_https_name}"
    },
    {
      priority                   = var.request_routing_rules_https_priority
      name                       = "${local.prefix_name}-${var.request_routing_rules_https_name}"
      rule_type                  = var.request_routing_rules_rule_type
      http_listener_name         = "${local.prefix_name}-${var.https_listener_name}"
      backend_address_pool_name  = "${local.prefix_name}-${var.backend_address_pools_name}"
      backend_http_settings_name = var.backend_http_settings_name
    }
  ]

  redirect_configuration = [
    {
      name                 = "${local.prefix_name}-${var.redirect_config_https_name}"
      target_listener_name = "${local.prefix_name}-${var.https_listener_name}"
      redirect_type        = var.redirect_configuration_redirect_type
      include_path         = true
      include_query_string = true
    }
  ]
  # TLS termination (previously known as Secure Sockets Layer (SSL) Offloading)
  # The certificate on the listener requires the entire certificate chain (PFX certificate) to be uploaded to establish the chain of trust.
  # Authentication and trusted root certificate setup are not required for trusted Azure services such as Azure App Service.
  ssl_certificates = [
    {
      name     = "${local.prefix_name}-${var.ssl_cert_name}"
      data     = "./artifacts/cert-key/certificate.pfx"
      password = "testkey"
    }
  ]

  # WAF configuration, disabled rule groups and exclusions.depends_on
  # The Application Gateway WAF comes pre-configured with CRS 3.0 by default. But you can choose to use CRS 3.2, 3.1, or 2.2.9 instead.
  # CRS 3.2 is only available on the `WAF_v2` SKU.
  waf_configuration = {
    firewall_mode            = var.firewall_mode
    rule_set_version         = var.rule_set_version
    file_upload_limit_mb     = var.file_upload_limit_mb
    max_request_body_size_kb = var.max_request_body_size_kb

    disabled_rule_group = var.disabled_rule_group

    exclusion = var.exclusion
  }

  # A list with a single user managed identity id to be assigned to access Keyvault
  identity_ids = ["${azurerm_user_assigned_identity.example.id}"]

  # (Optional) To enable Azure Monitoring for Azure Application Gateway
  # (Optional) Specify `storage_account_name` to save monitoring logs to storage.
  # log_analytics_workspace_name = azurerm_log_analytics_workspace.example.name
  # Adding TAG's to Azure resources
  tags = local.tags
  depends_on = [module.vnet]
}
