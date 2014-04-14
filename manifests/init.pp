class thrift {
  $yum_pkgs = [ "boost-devel",
                "boost-test",
                "boost-program-options",
                "libevent-devel",
                "automake",
                "libtool",
                "flex",
                "bison",
                "pkgconfig",
                "gcc-c++",
                "openssl-devel",]
  $apt_pkgs = [ "libboost-dev",
                "libboost-test-dev",
                "libboost-program-options-dev",
                "libevent-dev",
                "automake",
                "libtool",
                "flex",
                "bison",
                "pkg-config",
                "g++",
                "libssl-dev",]

  if $::osfamily == "RedHat" {
    $pkgs = $yum_pkgs
  }
  elsif $::operatingsystem == "Amazon" {
    $pkgs = $yum_pkgs
  }
  else {
    $pkgs = $apt_pkgs
  }

  package { $pkgs:
    ensure => present,
    before => Instool['thrift-0.9.1'],
  }

  #package { 'rspec':
  #  ensure   => 'installed',
  #  provider => 'gem',
  #  before   => Instool['thrift-0.9.1'],
  #}

  instool { "thrift-0.9.1":
    url  => "https://dist.apache.org/repos/dist/release/thrift/0.9.1/thrift-0.9.1.tar.gz",
    onlyif => [
      "test ! -x /usr/local/bin/thrift"
    ]
  }
}

define instool (
  $thing=$title,
  $dest="/usr/local/lib",
  $onlyif=undef,
  $url,
) {
  $tmpdir = "/tmp/${thing}"
  $instdir = "${dest}/${thing}"
  $buildpkgs = ["tar", "make"]

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

  exec{"download_and_untar":
    provider => shell,
    command  => "wget -qO- ${url} | tar xzf - -C /tmp",
    onlyif   => $onlyif;
  }

  file{$instdir:
    ensure  => directory,
    recurse => true,
    source  => $tmpdir;
  }

  exec{["./configure", "make", "make install", "make clean"]:
    provider => shell,
    cwd      => $instdir,
    onlyif   => $onlyif;
  }

  notify {"install ${name} from ${url} to ${dest}/${name}":}

  File[$tmpdir] -> Package[$buildpkgs] -> Exec['download_and_untar'] -> File[$instdir] ->
  Exec["./configure"] -> Exec['make'] -> Exec['make install'] -> Exec['make clean']
}
