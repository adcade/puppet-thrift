class thrift {
  $pkgs = [ "libboost-dev",
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

  package { $pkgs:
    ensure => present,
    before => Instool['thrift-0.9.0'],
  }

  #package { 'rspec':
  #  ensure   => 'installed',
  #  provider => 'gem',
  #  before   => Instool['thrift-0.9.0'],
  #}

  instool { "thrift-0.9.0":
    url    => "https://dist.apache.org/repos/dist/release/thrift/0.9.0/thrift-0.9.0.tar.gz",
    onlyif => [
      "test -x thrift"
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
  $buildpkgs = ["wget", "tar", "make"]

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
