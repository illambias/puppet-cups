class cups::client {

  # cups-browsed is necessary with cups >= 1.6 to automatically
  # install discoverable printers

  if $::lsbdistcodename =~ /sid|raring|saucy/ {

    package {'cups-browsed':
      ensure => present,
    }

    service {'cups-browsed':
      ensure => running,
      pattern => 'cups-browsed',
      enable  => true,
      require => Package ['cups-browsed'],
    }

  }

}
