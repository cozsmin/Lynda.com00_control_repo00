class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
  }

  package {'wget':
    ensure => installed,
  }
}

