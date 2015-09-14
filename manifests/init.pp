class mcollective (
  $activemq_pool_host    = $mcollective::params::activemq_host,
  $activemq_pool_port    = $mcollective::params::activemq_port,
  $activemq_pool_user    = $mcollective::params::activemq_user,
  $activemq_pool_pass    = $mcollective::params::activemq_pass,
  $use_server            = true,
  $use_client            = true,
  ) inherits mcollective::params {

  if $use_server == true {
    class { '::mcollective::server':
      activemq_pool_host => $activemq_pool_host,
      activemq_pool_port => $activemq_pool_port,
      activemq_pool_user => $activemq_pool_user,
      activemq_pool_pass => $activemq_pool_pass,
    }
    contain mcollective::facts
    contain mcollective::plugins
  }

  if $use_client == true {
    class { '::mcollective::client':
      activemq_pool_host => $activemq_pool_host,
      activemq_pool_port => $activemq_pool_port,
      activemq_pool_user => $activemq_pool_user,
      activemq_pool_pass => $activemq_pool_pass,
    }
    contain mcollective::plugins
  }
}
