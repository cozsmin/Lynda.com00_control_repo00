class profile::base {
  user { 'ion':
    ensure => present,
    gid    => 'ion',
    home   => '/home/ion',
    shell  => '/bin/bash',
    comment => "This uzer was create in Puppet",
#    managehome => true,
  }

  group { 'ion':
    ensure => present,
  }


  file { '/home/ion/':
    ensure => directory,
    owner => 'ion',
	group => 'ion',
	mode  => '700',
  }


  file { '/home/ion/.ssh':
    ensure => directory,
    owner => 'ion',
	group => 'ion',
	mode  => '700',
  }

  ssh_authorized_key { 'root@puppet':
    ensure => present,
    user   => 'ion',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABgQC4FnKC85GW9lLTPe28ACt9UvVefCEnrSjCHjo57CRZRTr0DId7oO2haF/91/WOIi9RTl8rp3u+GAzK/X03BvgiJLkgXm5YyjuS+x3RKSjXMvWYRvs71JFjy+xuAaNcZN8rqeKKo2dlw2vaQAtuQAYbuGUAXiICEl/oZyurLeMJqyJifxiQTf1XU7EeIMxotDxlmJ6xV3qSXJDM470hdwgFuQWGsGOHZwI7qdxf3jpISKkX2+fcMNctsOu41kSzPO9cbtJOa/SJsdTvwOB/aVa8wPWrOWTHYYjUSGobiNj9TW71PynxJ3FxP2XllCVdrej2+Mh9KdNbCZ+5b7vHCZWgSqqaprFsJ7rvxZnLrvMezWpRxV0tZNzkFWtfneQNCyLzkTUWl3reQo+MKOf1XMhZRE7R6tWq96PYD5sig+zx6xbu+WVv+L1aYEB8q3Jo04ayjkmD1tAzjfLyUXux5AdTfA21sumhVZCZflFJaYmCwCelpEhuTDG5d0zsvOYmYuU='
  }
}


