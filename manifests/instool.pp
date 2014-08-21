# == Define: thrift::instool
#
#
define thrift::instool (
  $url,
  $thing=$title,
  $dest='/usr/local/src',
  $onlyif=undef,
) {
  $tmpdir = "/tmp/${thing}"
  $instdir = "${dest}/${thing}"
  $buildpkgs = ['tar', 'make']

  include wget
  include ant

  ensure_packages($buildpkgs)

  file {$tmpdir:
    ensure => directory,
    before => Exec['download_and_untar'],
  }

  notify {"${tmpdir} is ensured":
    subscribe => File[$tmpdir],
  }

  exec{'download_and_untar':
    provider => shell,
    command  => "wget -qO- ${url} | tar xzf - -C /tmp",
    onlyif   => $onlyif,
    before   => Package[$buildpkgs]
  }

  file{$instdir:
    ensure  => directory,
    recurse => true,
    source  => $tmpdir,
    before  => Exec['download_and_untar'],
  }

  exec{['./configure --without-python --without-tests', 'make', 'make install', 'make clean']:
    provider => shell,
    cwd      => $instdir,
    onlyif   => $onlyif,
    require  => File[$instdir],
  }

  notify {"install ${name} from ${url} to ${dest}/${name}":}

  Exec['./configure --without-python --without-tests'] ->
  Exec['make'] ->
  Exec['make install'] ->
  Exec['make clean']
}
