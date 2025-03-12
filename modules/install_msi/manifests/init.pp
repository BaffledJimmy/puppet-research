class install_msi {

  $msi_path = '\\fileserver01\software\redteam.msi'
  $log_path = 'C:\Windows\Temp\redteam_install.log'

  # Ensure the MSI exists before running
  exec { 'install_redteam_msi':
    command => "msiexec /i '${msi_path}' /qn /L*v ${log_path}",
    onlyif  => "Test-Path '${msi_path}'",
    provider => 'powershell',
  }
}
