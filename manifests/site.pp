node default {
  file { '/tmp/node_default':
    ensure => file,
    content => "Los ACUCARACIAS\n",
    owner   => 'bin',
  }
}

node 'puppet' {
  include role::master_server
  file { '/tmp/node_puppet':
    ensure => file,
    content => 'Los ACUCARACIAS 333\n',
  }

  file { "/opt/nfs":
    ensure => directory,
  }

  package { 'wget':
    ensure => present,
  }

  package { 'nfs-utils':
    ensure => present,
  }

  file {'/etc/exports':
    ensure => file,
    mode => "644",
    owner => 'root',
    group => 'root',
  }

  file_line {'etc_exports':
    path => '/etc/exports',
    line => '/opt/nfs 192.168.56 (ro)',
  }

  service {'nfs-server':
    ensure => running,
    enable => true,
  }

  exec { 'wget minecraft.jar':
    command  => [ "/bin/bash" , "-c" , "if [ -f minecraft_server.jar ] ; then exit 0 ; fi; wget https://piston-data.mojang.com/v1/objects/45810d238246d90e811d896f87b14695b7fb6839/server.jar && mv -f server.jar minecraft_server.jar" ],
#    command  => [ "/bin/bash" , "-c" , "wget https://piston-data.mojang.com/v1/objects/45810d238246d90e811d896f87b14695b7fb6839/server.jar && mv -f server.jar minecraft_server.jar" ],
    cwd      => '/opt/nfs',
  }
}

node /^web|^d12b-ps/ {
  include role::app_server
}

node /^db|^d12c-ps/ {
  include role::db_server
  include role::minecraft
}

