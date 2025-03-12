# Puppet function to return an encryption command (but NOT check file existence)
function file_exfil::encrypt_file(
  String $filepath,
  String $key = 'WibbleDibbleMyKey123',
  String $iv = '1234567890123456'
) >> String {

  # Do not check file existence inside the function (Puppet Server cannot access agent files)
  $cmd = "base64 '${filepath}' | openssl enc -aes-256-cbc -salt -pbkdf2 -pass pass:'${key}' -base64 -iv '${iv}' > /tmp/encrypted_file.txt"

  return $cmd
}
