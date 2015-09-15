class mcollective::client(
  $activemq_pool_host     = $mcollective::params::activemq_host,
  $activemq_pool_port     = $mcollective::params::activemq_port,
  $activemq_pool_user     = $mcollective::params::activemq_user,
  $activemq_pool_pass     = $mcollective::params::activemq_pass,
  $mco_main_collective    = $mcollective::params::mco_server_main_collective,
  $mco_collectives        = $mcollective::params::mco_collectives,
  $mco_loglevel           = $mcollective::params::mco_loglevel,
  $activemq_pool_ssl_ca   = $mcollective::params::activemq_pool_ssl_ca,
  $activemq_pool_ssl_key  = $mcollective::params::activemq_pool_ssl_key,
  $activemq_pool_ssl_cert = $mcollective::params::activemq_pool_ssl_cert,
  $mco_security_provider  = $mcollective::params::mco_security_provider,
  $mco_plugin_yaml        = $mcollective::params::mco_plugin_yaml,
  $mco_registerinterval   = $mcollective::params::mco_registerinterval,
  $mco_registration       = $mcollective::params::mco_registration,
  $mco_service_name       = $mcollective::params::mco_service_name,
  $mco_server_public      = $mcollective::params::mco_server_public,
  $mco_client_public      = $mcollective::params::mco_client_public,
  $mco_client_private     = $mcollective::params::mco_client_private,
  ) inherits mcollective::params {

  file { 'client_cfg':
    ensure  => file,
    path    => "${mco_cfgdir}/client.cfg",
    content => template('mcollective/client.cfg.erb'),
  }

  file { 'client_key_default':
    ensure => file,
    path   => $mcollective::params::mco_client_private,
    source => 'puppet:///modules/mcollective/ssl/client-private.pem',
  }
}