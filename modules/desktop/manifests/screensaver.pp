class desktop::screensaver {
  gsetting { 'org.gnome.desktop.session idle-delay':
    ensure => 0,
    user   => 'gouda',
  }
  gsetting { 'org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type':
    ensure => 'nothing',
    user   => 'gouda',
  }
}
