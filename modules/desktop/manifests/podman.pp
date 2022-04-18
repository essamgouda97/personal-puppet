class desktop::podman {
  file { '/home/gouda/bin/docker':
    ensure  => 'link',
    target  => '/usr/bin/podman',
    owner   => 'gouda',
    group   => 'gouda',
    require => [Package['podman'], File['/home/gouda/bin']],
  }

  file { '/home/gouda/.config/containers':
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
