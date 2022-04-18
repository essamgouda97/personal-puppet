class desktop {
  include desktop::arduino # for arduino group permission
  include desktop::background # change ubuntu background
  include desktop::dotfiles # dotfiles management
  include desktop::homedir # setup home directory
  include desktop::launcher # launcher settings
  include desktop::podman # for running linux containers
  include desktop::purged # purge unused packages
  include desktop::pypy # setup python3.9, purge the rest
  include desktop::screensaver # screensaver settings
  include desktop::venv # setup virtualenv packages
  include desktop::virtualbox # vb permissions
  include desktop::workspace # workspace dir setup

  include packages::debian_packaging
  include packages::build_deps
  include packages::editors
  include packages::gnome_terminal
  include packages::node
  include packages::podman # for running linux containers
  include packages::python
  include packages::utilities

  if ! $::is_virtual { #if not a virtual machine
    include packages::vlc
    include packages::virtualbox
  }
}
