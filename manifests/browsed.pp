class cups::browsed {

  # Since CUPS 1.6, there is a separate daemon responsible for discovering
  # network printers using Avahi and optionally the legacy CUPS protocol.

  validate_re ($::lsbdistcodename, 'sid|raring|saucy', 'cups-browsed only exists with cups >= 1.6')

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
