node some-node {

  # https://github.com/mr-anderson86/puppet-defaults
  include defaults

  # https://forge.puppet.com/puppet/python
  class { 'python' :
    ensure      => 'present',
    version     => 'rh-python36-python',
    dev         => 'present',
    virtualenv  => 'present',
  }

  # My maven module module installes maven 3.6.0
  # It also installes java-1.8.0-openjdk-devel
  # (You can always user package 'maven' and then it'll install maven 3.0 and jdk non devel 1.8)
  # (Still need to implement this class)
  include maven
  
  user { 'devuser' :
    ensure      => present,
    password    => 'some hash password',
    shell       => '/bin/bash',
  }
  
  file { '/homr/devuser' : 
    ensure      => directory,
    owner       => devuser,
    group       => devuser,
    mode        => '0700',
    require     => User['devuser'],
  }
  
  file { '/homr/devuser/.bash_profile' :
    ensure      => file,
    owner       => devuser,
    group       => devuser,
    mode        => '0644',
    source      => "puppet:///modules/defaults/.bash_profile"
    require     => [
      User['devuser'],
      File['/homr/devuser'],
    ],
  }
  
  file { '/homr/devuser/.bashrc' :
    ensure      => file,
    owner       => devuser,
    group       => devuser,
    mode        => '0644',
    source      => "puppet:///modules/defaults/.bashrc"
    require     => [
      User['devuser'],
      File['/homr/devuser'],
    ],
  }
}
