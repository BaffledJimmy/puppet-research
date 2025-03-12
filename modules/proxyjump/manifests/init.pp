class proxyjump {
  file { '/etc/ssh/sshd_config.d/proxyjumpbackdoor_config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/proxyjump/sshd_config',
    #require => Package['openssh-server'], For regular VMs with sshd as a service
    #notify  => Service['ssh'],
  }
}
# Commented out as the containers don't use systemctl, but regular VMs will.
#  service { 'ssh':
#    ensure    => running,
#    enable    => true,
#    hasrestart => true,
#    subscribe => File['/etc/ssh/sshd_config'],
#  }
#}
