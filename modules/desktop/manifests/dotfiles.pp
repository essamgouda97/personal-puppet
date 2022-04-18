class desktop::dotfiles {
  $dotfiles = [
    '.zshrc', '.zsh_aliases', '.gitconfig', '.nanorc', '.pdbrc',
    '.pypirc', '.pythonrc.py', '.tmux.conf',
  ]
  $binfiles = [
    'bash/git-happy-merge', 'python/bump', 'python/git-github-compare',
    'python/git-github-fork', 'python/git-github-url',
    'python/inotify-exec', 'python/prune-remote-branches',
  ]

  vcsrepo { '/home/gouda/workspace/scratch':
    ensure   => 'present',
    user     => 'gouda',
    provider => 'git',
    source   => 'git@github.com:essamgouda97/scratch',
  }

  $dotfiles.each |$f| {
    file { "/home/gouda/${f}":
      ensure  => 'link',
      target  => "/home/gouda/workspace/scratch/${f}",
      owner   => 'gouda',
      group   => 'gouda',
      require => Vcsrepo['/home/gouda/workspace/scratch'],
    }
  }

  $binfiles.each |$f| {
    file { "/home/gouda/bin/${basename($f)}":
      ensure  => 'link',
      target  => "/home/gouda/workspace/scratch/${f}",
      owner   => 'gouda',
      group   => 'gouda',
      require => [
        Vcsrepo['/home/gouda/workspace/scratch'],
        File['/home/gouda/bin'],
      ],
    }
  }

  # many scripts use this, though we can't set contents quite yet
  file { '/home/gouda/.github-auth.json':
    ensure => 'present',
    owner  => 'gouda',
    group  => 'gouda',
    mode   => '0600',
  }

  # TODO: remove eventually
  file { '/home/gouda/bin/prune-remote-branches.py': ensure => 'absent' }
}
