class desktop::homedir {
  file { [
    '/home/gouda/Documents',
    '/home/gouda/Pictures',
    '/home/gouda/Public',
    '/home/gouda/Templates',
    '/home/gouda/Videos',
    '/home/gouda/Desktop',
    '/home/gouda/Downloads',
    '/home/gouda/Music',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }

  file { ['/home/gouda/bin', '/home/gouda/opt']:
    ensure => 'directory',
    owner  => 'gouda',
    group  => 'gouda',
  }
}
