class mcollective::facts(
    $mco_plugin_yaml = $mcollective::params::mco_plugin_yaml,
    $mco_optdir      = $mcollective::params::puppet_optdir,
    ) inherits mcollective::params {

  $facter_args = '/puppet/bin/facter --show-legacy'

  $facter_generate = $::kernel ? {
    'linux'   => "export LC_ALL='en_US.UTF-8' && ${mco_optdir}${facter_args} > ${mco_plugin_yaml}",
    'windows' => "${mco_optdir}${facter_args} > ${mco_plugin_yaml}",
  }

  if $::kernel == 'windows' {
    scheduled_task { 'Gerador do facter.yaml':
      ensure    => present,
      enabled   => true,
      command   => $facter_generate,
      trigger => {
        schedule         => daily,
        start_time       => '00:00',
        minutes_interval => 30,
        minutes_duration => 1440,
      }
    }

  if $::kernel == 'linux' {
    cron { 'roda_facter_linux':
      command  => $facter_generate,
      user     => 'root',
      month    => '*',
      monthday => '*',
      hour     => '*',
      minute   => '*/30',
    }
  }
}
