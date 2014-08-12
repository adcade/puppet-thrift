class thrift {

  $yum_pkgs = [
    'boost-devel',
    'boost-test',
    'boost-program-options',
    'libevent-devel',
    'automake',
    'libtool',
    'flex',
    'bison',
    'pkgconfig',
    'gcc-c++',
    'openssl-devel',
  ]

  $apt_pkgs = [
    'libboost-dev',
    'libboost-test-dev',
    'libboost-program-options-dev',
    'libevent-dev',
    'automake',
    'libtool',
    'flex',
    'bison',
    'pkg-config',
    'g++',
    'libssl-dev',
  ]

  case $::osfamily {
    'RedHat', 'Amazon': {
      $pkgs = $yum_pkgs
    }

    'Debian': {
      $pkgs = $apt_pkgs
    }

    default: {
      fail('Unsupported OS Family')
    }
  }

  package { $pkgs:
    ensure => present,
    before => Thrift::Instool['thrift-0.9.1'],
  }

  #package { 'rspec':
  #  ensure   => 'installed',
  #  provider => 'gem',
  #  before   => Instool['thrift-0.9.0'],
  #}

  thrift::instool { 'thrift-0.9.1':
    url    => 'http://apache.osuosl.org/thrift/0.9.1/thrift-0.9.1.tar.gz',
    onlyif => [
      'test ! -x /usr/local/bin/thrift'
    ]
  }
}
