class desktop::workspace {
  file { '/home/gouda/workspace':
    ensure => 'directory',
    mode   => '0755',
    owner  => 'gouda',
    group  => 'gouda',
  }

  $repos = [] #add long-term repos here


  $repos.each |$repo| {
    $name = basename($repo)
    vcsrepo { "/home/gouda/workspace/${name}":
      ensure   => 'present',
      user     => 'gouda',
      provider => 'git',
      source   => "git@github.com:${repo}",
    }
  }

  # zsh plugins
  file { '/home/gouda/.oh-my-zsh/custom/plugins/zsh-autosuggestions':
    ensure => 'directory',
    owner  => 'gouda',
    group  => 'gouda',
  } ->
  vcsrepo { '/home/gouda/.oh-my-zsh/custom/plugins/zsh-autosuggestions':
    ensure   => 'present',
    user     => 'gouda',
    provider => 'git',
    source   => 'git@github.com:zsh-users/zsh-autosuggestions',
  }
  
  file { '/home/gouda/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting':
    ensure => 'directory',
    owner  => 'gouda',
    group  => 'gouda',
  } ->
  vcsrepo { '/home/gouda/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting':
    ensure   => 'present',
    user     => 'gouda',
    provider => 'git',
    source   => 'git@github.com:zsh-users/zsh-syntax-highlighting',
  }
}
