class mcollective::plugins (
  $mco_plugindir = $mcollective::params::mco_plugindir,
  ) inherits mcollective::params {

  file { $mco_optdir:
    ensure  => directory,
  }

  file { $mco_plugindir:
    ensure  => directory,
  }

  file { 'mcollective_plugins':
    ensure  => directory,
    path    => "${mco_plugindir}/mcollective",
    source  => 'puppet:///modules/mcollective/plugins/mcollective',
    recurse => true,
    purge   => true,
    force   => true,
    notify  => Service[$mcollective::params::mco_service_name],
  }
}