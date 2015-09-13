class mcollective::plugins (
  $mcoplugin_dir = $mcollective::params::mcoplugin_dir,
  ) inherits mcollective::params {

  file { $mcoplugin_dir:
    ensure  => directory,
  }

  file { 'mcollective_plugins_dir':
    ensure  => directory,
    path    => $mcoplugin_dir,
    source  => 'puppet:///modules/mcollective/plugins',
    recurse => true,
    purge   => true,
    force   => true,
  }
}