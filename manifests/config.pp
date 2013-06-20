define cups::config (
  $ensure='present',
  $file='/etc/cups/cupsd.conf',
  $service='cups',
  $section='',
  $key='',
  $value=''
) {

  $real_key = $key ? {
    ''      => $name,
    default => $key,
  }

  # Append a / to section if passed
  $real_section = $section ? {
    ''      => '',
    default => "${section}/",
  }

  case $ensure {

    present: {
      if $value {
        $changes = [
          "set ${real_section}directive[.='${real_key}'] '${real_key}'",
          "set ${real_section}directive[.='${real_key}']/arg '${value}'",
        ]
      } else {
        fail ('You must provide a value')
      }
    }

    absent: {
      $changes = "rm ${real_section}directive[.='${real_key}']"
    }

    default: { fail ("Wrong value for ensure: ${ensure}") }
  }

  augeas {"Manage ${name} in ${file}":
    incl    => $file,
    lens    => 'Cups.lns',
    changes => $changes,
    notify  => Service[$service],
  }
}
