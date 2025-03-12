function env_exfil::encrypt_aes(
  String $plaintext,
  String $key = 'WibbleDibbleMyKey123',
  String $iv = '1234567890123456'
) >> String {

  # Base64 encode the plaintext
  $base64_text = base64('encode', $plaintext)

  # Return the OpenSSL command as a string
  $cmd = "echo '${base64_text}' | openssl enc -aes-256-cbc -salt -pbkdf2 -pass pass:${key} -base64 -iv ${iv} > /tmp/encrypted_data.txt"

  return $cmd
}
