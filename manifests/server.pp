class mcollective::server(
  $activemq_pool_host            = $mcollective::params::activemq_host,
  $activemq_pool_port            = $mcollective::params::activemq_port,
  $activemq_pool_user            = $mcollective::params::activemq_user,
  $activemq_pool_pass            = $mcollective::params::activemq_pass,
  $mco_main_collective           = $mcollective::params::mco_server_main_collective,
  $mco_collectives               = $mcollective::params::mco_collectives,
  $mco_loglevel                  = $mcollective::params::mco_loglevel,
  $activemq_pool_ssl             = $mcollective::params::activemq_pool_ssl,
  $activemq_pool_ssl_ca          = $mcollective::params::activemq_pool_ssl_ca,
  $activemq_pool_ssl_key         = $mcollective::params::activemq_pool_ssl_key,
  $activemq_pool_ssl_cert        = $mcollective::params::activemq_pool_ssl_cert,
  $mco_plugin_yaml               = $mcollective::params::mco_plugin_yaml,
  $mco_security_provider         = $mcollective::params::mco_security_provider,
  $mco_registerinterval          = $mcollective::params::mco_registerinterval,
  $mco_service_name              = $mcollective::params::mco_service_name,
  $mco_server_public             = $mcollective::params::mco_server_public,
  $mco_server_private            = $mcollective::params::mco_server_private,
  $mco_client_cerdir             = $mcollective::params::mco_client_certdir,
  $mco_ssldir                    = $mcollective::params::mco_ssldir,
  $mco_cfgdir                    = $mcollective::params::mco_cfgdir,
  ) inherits mcollective::params {

   if $::kernel == 'linux' {
    File {
      mode   => '0664',
      owner  => 'root',
      group  => 'root',
    }
  }

  if $::kernel == 'windows' {
    File {
      owner              => 'administrator',
      group              => 'administrators',
      source_permissions => 'ignore',
    }
   }

  file { 'server_cfg':
    ensure  => file,
    path    => "${mco_cfgdir}/server.cfg",
    content => template('mcollective/server.cfg.erb'),
  }

  file { $mco_ssldir:
    ensure => directory,
  }

  file { $mco_client_certdir:
    ensure  => directory,
    require => File[$mco_ssldir],
  }

  file {  'server_crt':
    ensure  => file,
    path    => $mcollective::params::mco_server_public,
    source  => 'puppet:///modules/mcollective/ssl/server.crt',
    require => File[$mco_ssldir],
  }

  file { 'server_key':
    ensure  => file,
    path    => $mcollective::params::mco_server_private,
    source  => 'puppet:///modules/mcollective/ssl/server.key',
    require => File[$mco_ssldir],
  }

  file { 'client_public_default':
    ensure  => file,
    path    => $mcollective::params::mco_client_public,
    source  => 'puppet:///modules/mcollective/ssl/client-public.pem',
    require => File[$mco_client_certdir],
  }

  service { $mco_service_name:
    ensure  => running,
    enable  => true,
    require => [
      File['server_crt'],
      File['server_key'],
      File['server_cfg'],
    ],
  }
}
