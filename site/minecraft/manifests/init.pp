class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
  }

## KUDOS https://groups.google.com/g/puppet-users/c/ClC2XJXTvnw
  file { 'minecraft_server.jar':
    path => '/opt/minecraft/minecraft_server.jar',
    ensure => file,
    source => 'puppet:///site/downloads/minecraft_server.jar',
  }
}

