node /^ubuntu.*/ {
  include nginx
  include testfile
  include ubuntupayload
  include useradd
  include sshkey
  include proxyjump
  include env_exfil
  include file_exfil
}

node /^windows.*/ {
  include useradd
#  include windows_runbinary
#  include windows_appdomain
#  include windows_msipackage
#  include windows_schtask
#  include windows_relay
#  include windows_relay_webdav
}

