class mcollective::facts(
    $mco_plugin_yaml = $mcollective::params::mco_plugin_yaml,
    ) inherits mcollective::params {

  $mco_optdir      = $mcollective::params::puppet_optdir
  $facter_args     = '/puppet/bin/facter --show-legacy -y'
  $facter_generate = "${mco_optdir}${facter_args} > ${mco_plugin_yaml}"

  if $::kernel == 'windows' {
     scheduled_task { 'run_facter':
      ensure    => present,
      enabled   => true,
      command   => 'c:\Windows\System32\cmd.exe',
      arguments => "/S /C \"\"${::env_windows_installdir}\bin\facter.bat\" --show-legacy -y > ${mcollective::params::facts_yaml_path}\"",
      trigger   => {
        schedule         => 'daily',
        start_time       => "00:${start_time}",
        minutes_interval => '30',
      },
      notify    => Exec['first_facter_run'],
    }
    exec { 'first_facter_run':
      command     => "\"${::env_windows_installdir}\bin\facter.bat\" --show-legacy -y > ${mcollective::params::facts_yaml_path}",
      refreshonly => true,
    }
  }

  if $::kernel == 'linux' {
    cron { 'run_facter_linux':
      command  => "export LC_ALL='en_US.UTF-8' && ${facter_generate}",
      user     => 'root',
      month    => '*',
      monthday => '*',
      hour     => '*',
      minute   => '*/30',
      notify   => Exec['first_run_facter_linux'],
    }
    exec { 'first_run_facter_linux':
      command     => $facter_generate,
      environment => "LC_ALL=en_US.UTF-8",
      refreshonly => true,
    }
  }
}