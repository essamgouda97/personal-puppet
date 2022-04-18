class desktop::arduino {
  include packages::arduino

  exec { 'add gouda to dialout group':
    command => 'usermod --append --groups dialout gouda',
    unless  => join([
        'id --name --groups --zero gouda | ',
        'grep --quiet --null-data --line-regexp dialout',
    ]),
    path    => '/usr/sbin:/usr/bin:/bin',
  }
}
