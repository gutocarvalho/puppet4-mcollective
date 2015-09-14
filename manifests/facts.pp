class mcollective::facts(
    $mco_plugin_yaml = $mcollective::params::mco_plugin_yaml,
    $mco_optdir      = $mcollective::params::puppet_optdir,
    ) inherits mcollective::params {

  $facter_args = '/puppet/bin/facter --show-legacy'

  $roda_facter = $::kernel ? {
    'linux'   => "export LC_ALL='en_US.UTF-8' && ${mco_optdir}${facter_args} > ${mco_plugin_yaml}",
    'windows' => "${mco_optdir}${facter_args} > ${mco_plugin_yaml}",
  }

  if $::kernel == 'windows' {
    schedule { 'facter_window':
      period => hourly,
      repeat => 2,
    }
    exec { 'roda_facter_windows':
      command  => $roda_facter,
      provider => $mcollective::params::exec_provider,
      schedule => powershell,
    }
  }

  if $::kernel == 'linux' {
    cron { 'roda_facter_linux':
      command  => $roda_facter,
      user     => 'root',
      month    => '*',
      monthday => '*',
      hour     => '*',
      minute   => '*/30',
    }
  }
}
