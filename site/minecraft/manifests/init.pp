class minecraft (  $install_dir = "/opt/minecraft" ) {

  file { $install_dir:
    ensure => directory,
    recurse => true,
  }

  file { "${install_dir}/eula.txt":
    ensure => file,
    content => 'eula=true',
  }

  file { '/mnt/puppet_nfs':
    ensure => directory,
  }

  package { 'nfs-common':
    ensure => installed,
  }

  package { 'openjdk-17-jdk':
    ensure => present,
  }

  exec { 'mount minecraft and copy it':
    command  => [ "/bin/bash" , "-c" , "if [ -f ${install_dir}/minecraft_server.jar ] ; then exit 0 ; fi ; mount puppet:/opt/nfs /mnt/puppet_nfs && cp /mnt/puppet_nfs/minecraft_server.jar ${install_dir} && umount /mnt/puppet_nfs/ " ],
#    notify => File["/etc/systemd/system/minecraft.service"]
    before => Service['minecraft']
  }

  file { '/etc/systemd/system/minecraft.service':
    ensure=> file,

    #content => template('minecraft/minecraft.service.erb'),
    content => epp('minecraft/minecraft.service', {
      install_dir => $install_dir, }
    ),
    # on server at /etc/puppetlabs/code/environments/production/site/minecraft/templates/minecraft.service.erb

    #source => 'puppet:///modules/minecraft/minecraft.service',
    # on server at /etc/puppetlabs/code/environments/production/site/minecraft/files/minecraft.service
    notify  => Exec["daemon-reload"],
  }

  exec { 'daemon-reload':
    command  => [ "/bin/bash" , "-c" , "systemctl daemon-reload" ],
    notify  => Service["minecraft"],
  }

  service {'minecraft':
    name => "minecraft",
    ensure => running,
    enable => true,
    require => [ Package['openjdk-17-jdk'] , File[$install_dir] , File["${install_dir}/eula.txt"], Exec['mount minecraft and copy it'] , File['/etc/systemd/system/minecraft.service'] ]
  }

}

