class wat {
  file {
    '/home/asottile/wat':
      ensure => file,
      source => 'puppet:///modules/wat/wat',
      owner  => 'asottile',
      group  => 'asottile',
  }
}
