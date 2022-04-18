class desktop::virtualbox {
  if $::is_virtual and $::virtual == 'virtualbox' {
    exec { 'add gouda to vboxsf group':
      command => 'usermod --append --groups vboxsf gouda',
      unless  => join([
          'id --name --groups --zero gouda | ',
          'grep --quiet --null-data --line-regexp vboxsf',
      ]),
      path    => '/usr/sbin:/usr/bin:/bin',
    }
  }
}
