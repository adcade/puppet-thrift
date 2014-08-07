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
    before => Instool['thrift-0.9.1'],
  }

  #package { 'rspec':
  #  ensure   => 'installed',
  #  provider => 'gem',
  #  before   => Instool['thrift-0.9.0'],
  #}

  instool { 'thrift-0.9.1':
    url    => 'http://apache.osuosl.org/thrift/0.9.1/thrift-0.9.1.tar.gz',
    onlyif => [
      'test ! -x /usr/local/bin/thrift'
    ]
  }
}

define instool (
  $url,
  $thing=$title,
  $dest='/usr/local/lib',
  $onlyif=undef,
) {
  $tmpdir = "/tmp/${thing}"
  $instdir = "${dest}/${thing}"
  $buildpkgs = ['tar', 'make']

  include wget

  package { $buildpkgs:
    ensure => present,
  }

  file {$tmpdir:
    ensure  => directory,
  }

  notify {"${tmpdir} is ensured":
    subscribe => File[$tmpdir],
  }

  exec{'download_and_untar':
    provider => shell,
    command  => "wget -qO- ${url} | tar xzf - -C /tmp",
    onlyif   => $onlyif;
  }

  file{$instdir:
    ensure  => directory,
    recurse => true,
    source  => $tmpdir;
  }

  exec{['./configure --without-python --without-tests', 'make', 'make install', 'make clean']:
    provider => shell,
    cwd      => $instdir,
    onlyif   => $onlyif;
  }

  notify {"install ${name} from ${url} to ${dest}/${name}":}

  File[$tmpdir] -> Package[$buildpkgs] -> Exec['download_and_untar'] -> File[$instdir] ->
  Exec['./configure --without-python --without-tests'] -> Exec['make'] -> Exec['make install'] -> Exec['make clean']
}
