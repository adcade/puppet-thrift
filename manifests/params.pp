# == Class: thrift::params
#
class thrift::params {
  $version = '0.9.1'
  $base_url = 'https://archive.apache.org/dist/thrift'
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
    'java-1.7.0-openjdk-devel',
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
    'openjdk-7-jdk',
    'libcommons-lang3-java',
  ]

  case $::osfamily {
    'RedHat', 'Amazon': {
      $pkgs = $yum_pkgs
    }

    'Debian': {
      $pkgs = $apt_pkgs
    }

    default: {
      fail("${::osfamily} not supported")
    }
  }
}
