# == Class: thrift
#
# Downloads, compiles and installs thrift
#
# === Parameters
#
# [*version*]
#   Sets the thrift version, module defaults to the 0.9.1 for now
# [*base_url*]
#   Url where to download thrift
# [*pkgs*]
#   Array with packages to install
#
# === Examples
#
# include thrift
#
# === Authors
#
# Sebastian Otaegui <feniix@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sebastian Otaegui, unless otherwise noted.
#
class thrift(
  $version = $thrift::params::version,
  $base_url = $thrift::params::base_url,
  $pkgs = $thrift::params::pkgs,
) inherits thrift::params {

  validate_re($version, '^\d+\.\d+\.\d+$')
  validate_array($pkgs)

  case $::osfamily {
    'RedHat', 'Amazon', 'Debian': {
      notify { "${::operatingsystem} is supported": }
    }
    default: {
      fail("${::osfamily} not supported")
    }
  }

  package { $pkgs:
    ensure => present,
    before => Thrift::Instool["thrift-${version}"],
  }

  thrift::instool { "thrift-${version}":
    url    => "${base_url}/${version}/thrift-${version}.tar.gz",
    onlyif => [
      'test ! -x /usr/local/bin/thrift'
    ]
  }
}
