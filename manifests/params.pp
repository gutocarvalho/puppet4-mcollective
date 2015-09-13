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
      owner              => 'administrator',
      group              => 'administrators',
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

  $mcoplugin_dir = $::kernel ? {
    linux   => "${puppet_optdir}/mcollective/plugins/mcollective",
    windows => "${puppet_optdir}/mcollective/plugins/mcollective",
  }

  $mco_logfile = $::kernel ? {
    linux   => '/var/log/mcollective.log',
    windows => 'c:/programdata/puppetlabs',
  }

  $mco_classesfile = $::kernel ? {
    linux   => '/var/lib/puppet/state/classes.txt',
    windows => '/var/lib/puppet/state/classes.txt',
  }

  $puppet_ssldir                 = "${puppet_cfgdir}/puppet/ssl"

  $mco_service_name              = 'mcollective'
  $mco_cfgdir                    = "${puppet_cfgdir}/mcollective"
  $mco_libdir                    = "${puppet_optdir}/puppet/lib/ruby/vendor_ruby:${puppet_optdir}/mcollective/plugins"
  
  $activemq_host                 = $::ipaddress
  $activemq_port                 = '61614'
  $activemq_user                 = 'mcollective'
  $activemq_pass                 = 'marionette'

  $mco_server_main_collective    = 'mcollective'
  $mco_collectives               = 'mcollective'

  $mco_loglevel                  = 'info'
  $mco_identity                  = $::fqdn
  $mco_daemonize                 = '1'
  $mco_direct_addressing         = '0'
  $mco_security_provider         = 'ssl'
  
  $mco_connector                 = 'activemq'

  $activemq_pool_size            = '1'
  $activemq_pool_host            = $activemq_host
  $activemq_pool_port            = $activemq_port
  $activemq_pool_user            = $activemq_user
  $activemq_pool_password        = $activemq_pass
  $activemq_pool_ssl             = true
  $activemq_pool_ssl_ca          = "${puppet_ssldir}/ca/ca_crt.pem"
  $activemq_pool_ssl_key         = "${puppet_ssldir}/private_keys/${::fqdn}.pem"
  $activemq_pool_ssl_cert        = "${puppet_ssldir}/certs/${::fqdn}.pem"

  $mco_ssldir                    = "${puppet_cfgdir}/mcollective/ssl"
  $mco_client_certdir            = "${mco_ssldir}/clients"

  $mco_server_private            = "${mco_ssldir}/server.key"
  $mco_server_public             = "${mco_ssldir}/server.crt"

  $mco_client_private            = "${mco_client_certdir}/client-private.pem"
  $mco_client_public             = "${mco_client_certdir}/client-public.pem"
  
  $mco_plugin_package_provider   = 'puppet'
  $mco_factsource                = 'yaml'

  $mco_plugin_yaml               = "${mco_cfgdir}/facts.yaml"
  
  $mco_registerinterval          = '300'
  $mco_registration              = 'Agentlist'

}