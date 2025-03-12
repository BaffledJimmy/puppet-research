# Consider using this upgraded module instead: https://forge.puppet.com/modules/puppetlabs/scheduled_task/readme
class windows_schtask {

  scheduled_task { 'RedTeamTask':
    ensure    => present,
    command   => 'C:\users\public\implant.exe',
    arguments => '""',
    enabled   => true,
    trigger   => [{
      schedule => 'weekly',
      day_of_week => ['mon'],
      start_time  => '09:00',
    }],
    user      => 'SYSTEM',
  }
}
