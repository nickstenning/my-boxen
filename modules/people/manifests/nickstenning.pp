class people::nickstenning {
  include adium
  include alfred
  include chrome
  include dropbox
  include dnsmasq
  include iterm2::dev
  include macvim
  include mailplane::beta
  include onepassword
  include turn-off-dashboard
  include theunarchiver
  include zsh

  $home = "/Users/${::luser}"
  $code = "${home}/code"
  $dotfiles = "${code}/dotfiles"

  repository { $dotfiles:
    source  => 'nickstenning/dotfiles',
    require => File[$code],
    notify  => Exec['install-dotfiles'],
  }

  exec { 'install-dotfiles':
    cwd         => $dotfiles,
    command     => 'redo',
    refreshonly => true,
    require     => Package['redo'],
  }

  repository { "${code}/vim":
    source  => 'nickstenning/dotvim',
    require => File[$code],
    notify  => Exec['install-dotvim'],
  }

  exec { 'install-dotvim':
    cwd         => "${code}/vim",
    command     => 'sh install',
    refreshonly => true,
  }

  repository { "${home}/.virtualenvs":
    source  => 'nickstenning/dotvirtualenvs',
  }

  package {
    [
      'autoenv',
      'coreutils',
      'ctags',
      'curl-ca-bundle',
      'daemontools',
      'dash',
      'elasticsearch',
      'git',
      'go',
      'gnupg',
      'gpg-agent',
      'graphviz',
      'heroku-toolbelt',
      'htop-osx',
      'keychain',
      'mobile-shell',
      'mtr',
      'multimarkdown',
      'nginx',
      'parallel',
      'pstree',
      'pv',
      'pwgen',
      'python',
      'python3',
      'reattach-to-user-namespace',
      'redis',
      'redo',
      'rlwrap',
      's3cmd',
      'ssh-copy-id',
      'tmux',
      'tree',
      'watch',
      'wget',
      'xz',
      'z'
    ]:
    ensure => present,
  }
}
