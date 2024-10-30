class role::minecraft {

  #include minecraft
  class { 'minecraft':
    install_dir => '/opt/acucaracia/minecraft',
  }
}


