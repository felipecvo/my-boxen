require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $luser,

  path => [
#    "${boxen::config::home}/rbenv/shims",
#    "${boxen::config::home}/rbenv/bin",
#    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::luser}"
  ]
}

File {
  group => 'staff',
  owner => $luser
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  # include dnsmasq
  include git
  # include hub
  # include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  # include nodejs::v0_4
  # include nodejs::v0_6
  # include nodejs::v0_8
  # include nodejs::v0_10

  # default ruby versions
  # include ruby::1_8_7
  # include ruby::1_9_2
  # include ruby::1_9_3
  # include ruby::2_0_0

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'wget',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

  include ruby::ree
  include ruby::1_9_3
  include ruby::2_0_0
  ruby::version { '2.0.0-p247': }

  include virtualbox
  include vagrant
  vagrant::plugin { 'vagrant-vbguest': }

  include mysql
  #include postgresql

  include macvim
  include eclipse::java

  include dropbox
  include amazonclouddrive

  include redis

  include firefox

  include iterm2::stable
  include adium
  include sizeup
  include gitx::dev
  include limechat
  include keepassx
  include skype
  include sparrow

  include gimp

  #include audacity
  include caffeine
  include appcleaner
  include notational_velocity
  #include shiftit
  include calibre
  include dashlane
  include kindle
  include rdio
  include steam

  #homebrew::tap {  }

  #package { 'curl-ca-bundle':
  #  ensure => present,
  #}

  package { 'htop':
    ensure => present,
  }

  #package { 'libvirt':
  #  ensure => present,
  #}

  package { 'groovy':
    ensure => present,
  }

  package { 'bash-completion':
    ensure => present,
  }

  package { 'phantomjs':
    ensure => present,
  }

  file { "/work":
    ensure => directory,
  }

  file { "/work/projects":
    ensure  => directory,
    require => File["/work"],
  }

  file { "/work/abd":
    ensure  => directory,
    require => File["/work"],
  }

  file { "/work/unahi":
    ensure  => directory,
    require => File["/work"],
  }

  file { "/Users/${luser}/Music/iTunes/iTunes Media/Music":
    ensure => link,
    target => "/Users/${luser}/Cloud Drive/Music",
  }

  file { "/Users/${luser}/Music/iTunes/iTunes Library Extras.itdb":
    ensure => link,
    target => "/Users/${luser}/Cloud Drive/Music/iTunes Library Extras.itdb",
  }

  file { "/Users/${luser}/Music/iTunes/iTunes Library Genius.itdb":
    ensure => link,
    target => "/Users/${luser}/Cloud Drive/Music/iTunes Library Genius.itdb",
  }

  file { "/Users/${luser}/Music/iTunes/iTunes Library.itl":
    ensure => link,
    target => "/Users/${luser}/Cloud Drive/Music/iTunes Library.itl",
  }

  file { "/Users/${luser}/Music/iTunes/Music Library.xml":
    ensure => link,
    target => "/Users/${luser}/Cloud Drive/Music/Music Library.xml",
  }

  sudoers { 'ID1':
    users      => "${luser}",
    hosts      => 'ALL',
    commands   => '(ALL) NOPASSWD: ALL',
    comment    => 'pimp my comment',
    type       => 'user_spec',
  }
}
