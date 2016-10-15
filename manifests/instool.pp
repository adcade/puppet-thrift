# == Define: thrift::instool
#
#
define thrift::instool (
  $url,
  $thing=$title,
  $dest='/usr/local/src',
  $onlyif=undef,
) {
  $instdir = "${dest}/${thing}"

  include ant

  archive {'download_and_untar':
    ensure   => present,
    name     => $thing,
    url      => $url,
    target   => $dest,
    checksum => false,
    before   => File[$instdir],
    path    => $instdir,
  }

  file{$instdir:
    ensure  => directory,
    require => Archive['download_and_untar'],
  }

  exec{['./configure --without-python --without-tests', 'make', 'make install', 'make clean']:
    provider => shell,
    cwd      => $instdir,
    onlyif   => $onlyif,
    timeout  => 0,
  }

  notify {"install ${name} from ${url} to ${dest}/${name}":}

  File[$instdir] ->
  Exec['./configure --without-python --without-tests'] ->
  Exec['make'] ->
  Exec['make install'] ->
  Exec['make clean']
}
