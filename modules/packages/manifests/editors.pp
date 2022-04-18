class packages::editors {
  package { ['nano', 'vim-nox', 'vim']: ensure => 'latest' }
}
