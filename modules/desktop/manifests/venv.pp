class desktop::venv {
  $packages = [
    'aactivator', 'awshelp', 'flake8', 'pre-commit', 'tox', 'twine',
    'virtualenv',
  ]
  $venv = '/home/gouda/opt/venv'

  util::virtualenv { $venv: venv => $venv }

  # TODO: this is quite slow, ideally I'd like something like
  # venv { '/home/gouda/opt/venv':
  #     user => 'gouda',
  #     packages => $packages,
  # }
  $packages.each |$pkg| {
    util::pip {"${venv}(${pkg})":
      pkg     => $pkg,
      venv    => $venv,
      require => Util::Virtualenv[$venv],
    }
  }

  $packages.each |$bin| {
    file { "/home/gouda/bin/${bin}":
      ensure  => 'link',
      target  => "${venv}/bin/${bin}",
      owner   => 'gouda',
      group   => 'gouda',
      require => [
        File['/home/gouda/bin'],
        Util::Pip["${venv}(${bin})"],
      ],
    }
  }

  # awscli deps conflict a lot so put them in their own environment
  $venv_aws = '/home/gouda/opt/awscli'
  util::virtualenv { $venv_aws: venv => $venv_aws } ->
  util::pip { "${venv_aws}(awscli)": pkg => 'awscli', venv => $venv_aws} ->
  file { '/home/gouda/bin/aws':
    ensure  => 'link',
    target  => "${venv_aws}/bin/aws",
    owner   => 'gouda',
    group   => 'gouda',
    require => [
      File['/home/gouda/bin'],
      Util::Pip["${venv_aws}(awscli)"],
    ],
  }

  $venv_az = '/home/gouda/opt/azcli'
  util::virtualenv { $venv_az: venv => $venv_az } ->
  util::pip { "${venv_az}(azure-cli)": pkg => 'azure-cli', venv => $venv_az} ->
  file { '/home/gouda/bin/az':
    ensure  => 'link',
    target  => "${venv_az}/bin/az",
    owner   => 'gouda',
    group   => 'gouda',
    require => [
      File['/home/gouda/bin'],
      Util::Pip["${venv_az}(azure-cli)"],
    ],
  }
}
