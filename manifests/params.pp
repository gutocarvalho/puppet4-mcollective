class mcollective::params {

  if $::kernel == 'linux' {
    File {
      mode   => '0664',
      owner  => 'root',
      group  => 'root',
    }
  }

  if $::kernel == 'windows' {
    File {
      owner              => 'Administrator',
      group              => 'Administrators',
      source_permissions => 'ignore',
    }
  }

  $puppet_cfgdir = $::kernel ? {
    linux   => '/etc/puppetlabs',
    windows => 'c:/programdata/puppetlabs',
  }

  $puppet_optdir = $::kernel ? {
    linux   => '/opt/puppetlabs',
    windows => 'c:/programdata/puppetlabs',
  }

  $mco_logfile = $::kernel ? {
    linux   => '/var/log/mcollective.log',
    windows => 'c:/programdata/puppetlabs/mcollective/var/log/mcollective.log',
  }

  $mco_classesfile = $::kernel ? {
    linux   => '/var/lib/puppet/state/classes.txt',
    windows => 'c:/programdata/puppetlabs/puppet/cache/state/classes.txt',
  }

  $puppet_ssldir               = "${puppet_cfgdir}/puppet/ssl"

  $mco_optdir                  = "${puppet_optdir}/mcollective"
  $mco_plugindir               = "${mco_optdir}/plugins"
  $mco_cfgdir                  = "${puppet_cfgdir}/mcollective"
  $mco_libdir                  = "${puppet_optdir}/puppet/lib/ruby/vendor_ruby:${puppet_optdir}/mcollective/plugins"
  
  $mco_service_name            = 'mcollective'
  $mco_server_main_collective  = 'mcollective'
  $mco_collectives             = 'mcollective'

  $mco_loglevel                = 'info'
  $mco_identity                = $::trusted['certname']
  $mco_daemonize               = '1'
  $mco_direct_addressing       = '0'
  $mco_security_provider       = 'ssl'
  
  $mco_connector               = 'activemq'

  $activemq_pool_size          = '1'
  $activemq_pool_host          = $::ipaddress
  $activemq_pool_port          = '61614'
  $activemq_pool_user          = 'mcollective'
  $activemq_pool_password      = 'marionette'
  $activemq_pool_ssl           = true
  $activemq_pool_ssl_ca        = "${puppet_ssldir}/certs/ca.pem"
  $activemq_pool_ssl_key       = "${puppet_ssldir}/private_keys/${::trusted['certname']}.pem"
  $activemq_pool_ssl_cert      = "${puppet_ssldir}/certs/${::trusted['certname']}.pem"

  $mco_ssldir                  = "${puppet_cfgdir}/mcollective/ssl"
  $mco_client_certdir          = "${mco_ssldir}/clients"

  $mco_server_private          = "${mco_ssldir}/server.key"
  $mco_server_public           = "${mco_ssldir}/server.crt"

  $mco_client_private          = "${mco_client_certdir}/client-private.pem"
  $mco_client_public           = "${mco_client_certdir}/client-public.pem"
  
  $mco_plugin_package_provider = 'puppet'
  $mco_factsource              = 'yaml'

  $mco_plugin_yaml             = "${mco_cfgdir}/facts.yaml"
  
  $mco_registerinterval        = '300'
  $mco_registration            = 'Agentlist'

}
