class testfile {
  file { '/tmp/testfile':
    ensure  => present,
    content => 'Puppet applied this!',
  }
}
