class mcollective (
  $use_server             = true,
  $use_client             = false,
  $activemq_pool_host     = $mcollective::params::activemq_host,
  $activemq_pool_port     = $mcollective::params::activemq_port,
  $activemq_pool_user     = $mcollective::params::activemq_user,
  $activemq_pool_pass     = $mcollective::params::activemq_pass,
  $mco_main_collective    = $mcollective::params::mco_server_main_collective,
  $mco_collectives        = $mcollective::params::mco_collectives,
  $mco_loglevel           = $mcollective::params::mco_loglevel,
  $activemq_pool_ssl      = $mcollective::params::activemq_pool_ssl,
  $activemq_pool_ssl_ca   = $mcollective::params::activemq_pool_ssl_ca,
  $activemq_pool_ssl_key  = $mcollective::params::activemq_pool_ssl_key,
  $activemq_pool_ssl_cert = $mcollective::params::activemq_pool_ssl_cert,
  $mco_plugin_yaml        = $mcollective::params::mco_plugin_yaml,
  $mco_security_provider  = $mcollective::params::mco_security_provider,
  $mco_registerinterval   = $mcollective::params::mco_registerinterval,
  $mco_service_name       = $mcollective::params::mco_service_name,
  $mco_server_public      = $mcollective::params::mco_server_public,
  $mco_server_private     = $mcollective::params::mco_server_private,
  $mco_client_cerdir      = $mcollective::params::mco_client_certdir,
  $mco_client_public      = $mcollective::params::mco_client_public,
  $mco_client_private     = $mcollective::params::mco_client_private,
  ) inherits mcollective::params {

  if $use_server == true {
    class { '::mcollective::server':
      activemq_pool_host     => $activemq_pool_host,
      activemq_pool_port     => $activemq_pool_port,
      activemq_pool_user     => $activemq_pool_user,
      activemq_pool_pass     => $activemq_pool_pass,
      mco_main_collective    => $mco_server_main_collective,
      mco_collectives        => $mco_collectives,
      mco_loglevel           => $mco_loglevel,
      activemq_pool_ssl      => $activemq_pool_ssl,
      activemq_pool_ssl_ca   => $activemq_pool_ssl_ca,
      activemq_pool_ssl_key  => $activemq_pool_ssl_key,
      activemq_pool_ssl_cert => $activemq_pool_ssl_cert,
      mco_plugin_yaml        => $mco_plugin_yaml,
      mco_security_provider  => $mco_security_provider,
      mco_registerinterval   => $mco_registerinterval,
      mco_service_name       => $mco_service_name,
      mco_server_public      => $mco_server_public,
      mco_server_private     => $mco_server_private,
      mco_client_cerdir      => $mco_client_certdir,
    }
    contain mcollective::facts
    contain mcollective::plugins
  }

  if $use_client == true {
    class { '::mcollective::client':
      activemq_pool_host     => $activemq_pool_host,
      activemq_pool_port     => $activemq_pool_port,
      activemq_pool_user     => $activemq_pool_user,
      activemq_pool_pass     => $activemq_pool_pass,
      mco_main_collective    => $mco_server_main_collective,
      mco_collectives        => $mco_collectives,
      mco_loglevel           => $mco_loglevel,
      activemq_pool_ssl      => $activemq_pool_ssl,
      activemq_pool_ssl_ca   => $activemq_pool_ssl_ca,
      activemq_pool_ssl_key  => $activemq_pool_ssl_key,
      activemq_pool_ssl_cert => $activemq_pool_ssl_cert,
      mco_plugin_yaml        => $mco_plugin_yaml,
      mco_security_provider  => $mco_security_provider,
      mco_registerinterval   => $mco_registerinterval,
      mco_service_name       => $mco_service_name,
      mco_server_public      => $mco_server_public,
      mco_server_private     => $mco_server_private,
      mco_client_public      => $mco_client_public,
      mco_client_private     => $mco_client_private,
    }
    contain mcollective::plugins
  }
}
