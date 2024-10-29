class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
  }

  file { '/mnt/puppet_nfs':
    ensure => directory,
  }

  package { 'nfs-common':
    ensure => installed,
  }

  exec { 'mount minecraft and copy it':
    command  => [ "/bin/bash" , "-c" , "if [ -f /opt/minecraft/minecraft_server.jar ] ; then exit 0 ; fi ; mount puppet:/opt/nfs /mnt/puppet_nfs && cp /mnt/puppet_nfs/minecraft_server.jar /opt/minecraft/ && umount /mnt/puppet_nfs/ " ],
  }
}


