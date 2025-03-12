# https://www.puppet.com/docs/puppet/8/resources_package_windows#resources_package_windows
class windows_msipackage {
# The name of the package below must match DisplayName of the package otherwise Puppet doesn't know it is installed. Check what Puppet thinks the installed packages are via: puppet.bat resource package
  package { 'RedTeam': 
    ensure   => installed,
    source   => '\\\\fileserver01\\software\\redteam.msi',
    install_options => ['/my_custom_args'],
  }
}
