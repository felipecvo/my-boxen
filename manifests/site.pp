#class { 'homebrew':
#  installdir => '/usr/local',
#  libdir     => "/usr/local/lib",
#  cmddir     => "/usr/local/Library/Homebrew/cmd",
#  tapsdir    => "/usr/local/Library/Taps",
#  brewsdir   => "/usr/local/Library/Taps/brews",
#  user       => "root",
#}
#require boxen::environment
#require homebrew
#require gcc

#boxen::osx_defaults { "Terminal Default Window Settings":
#  ensure => present,
#  domain => "com.apple.Terminal",
#  key    => "Default Window Settings",
#  value  => "Pro",
#  user   => $luser,
#}
#
#boxen::osx_defaults { "Terminal Startup Window Settings":
#  ensure => present,
#  domain => "com.apple.Terminal",
#  key    => "Startup Window Settings",
#  value  => "Pro",
#  user   => $luser,
#}
#
#define plistbuddy(
#  $plist = undef,
#  $key   = undef,
#  $value = undef,
#  $user  = undef,
#) {
#  exec { "Plistbuddy -c 'Set $key $value'":
#    command => "/usr/libexec/PlistBuddy -c 'Set $key $value' $plist",
#    unless  => "/usr/libexec/PlistBuddy -c 'print $key' $plist | awk '{ exit \$0 != \"${value}\" }'",
#    user    => $user,
#  }
#}
#
#plistbuddy { 'TerminalShellExitAction':
#  plist => '~/Library/Preferences/com.apple.Terminal.plist',
#  key   => '"Window Settings":Pro:shellExitAction',
#  value => '0',
#  user  => $luser,
#}
#
#plistbuddy { 'TerminalFontAntiAlias':
#  plist => '~/Library/Preferences/com.apple.Terminal.plist',
#  key   => '"Window Settings":Pro:FontAntialias',
#  value => '1',
#  user  => $luser,
#}
#
#plistbuddy { 'TerminalFontBoldBright':
#  plist => '~/Library/Preferences/com.apple.Terminal.plist',
#  key   => '"Window Settings":Pro:UseBrightBold',
#  value => '1',
#  user  => $luser,
#}
#
##sudo scutil --set ComputerName "0x6D746873"
##sudo scutil --set HostName "0x6D746873"
##sudo scutil --set LocalHostName "0x6D746873"
##sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "0x6D746873"
#
#Exec {
#  group       => 'staff',
#  logoutput   => on_failure,
#  user        => $luser,
#
#  path => [
#    "${boxen::config::home}/rbenv/shims",
#    "${boxen::config::home}/rbenv/bin",
#    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
#    "${boxen::config::home}/homebrew/bin",
#    '/usr/bin',
#    '/bin',
#    '/usr/sbin',
#    '/sbin'
#  ],
#
#  environment => [
#    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
#    "HOME=/Users/${::luser}"
#  ]
#}
#
#File {
#  group => 'staff',
#  owner => $luser
#}
#
#Package {
#  provider => homebrew,
#  require  => Class['homebrew']
#}
#
#Repository {
#  provider => git,
#  extra    => [
#    '--recurse-submodules'
#  ],
#  require  => File["${boxen::config::bindir}/boxen-git-credential"],
#  config   => {
#    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
#  }
#}
#
#Service {
#  provider => ghlaunchd
#}
#
#Homebrew::Formula <| |> -> Package <| |>
#
#node default {
#  $dotfiles = "/Users/${::luser}/.dotfiles"
#
#  repository { $dotfiles:
#    source => "felipecvo/dotfiles",
#  }
#
#  exec { "install_dotfiles":
#    cwd     => $dotfiles,
#    command => "/bin/bash install.sh",
#    creates => "$dotfiles/.installed",
#    require => Repository[$dotfiles],
#  }
#
#  $vimfiles = "/Users/${::luser}/.vim"
#
#  repository { $vimfiles:
#    source => "felipecvo/vimfiles",
#  }
#
#  exec { "install_vimfiles":
#    cwd     => $vimfiles,
#    command => "/bin/sh setup.sh",
#    creates => "$vimfiles/.installed",
#    require => Repository[$vimfiles],
#  }
#  # core modules, needed for most things
#  # include dnsmasq
#  include git
#  # include hub
#  # include nginx
#
#  # fail if FDE is not enabled
#  if $::root_encrypted == 'no' {
#    fail('Please enable full disk encryption and try again')
#  }
#
#  # node versions
#  # include nodejs::v0_4
#  # include nodejs::v0_6
#  # include nodejs::v0_8
#  # include nodejs::v0_10
#
#  # default ruby versions
#  # include ruby::1_8_7
#  # include ruby::1_9_2
#  # include ruby::1_9_3
#  # include ruby::2_0_0
#
#  # common, useful packages
#  package {
#    [
#      'ack',
#      'findutils',
#      'wget',
#      'gnu-tar'
#    ]:
#  }
#
#  file { "${boxen::config::srcdir}/our-boxen":
#    ensure => link,
#    target => $boxen::config::repodir
#  }
#
#  #include ruby::ree
#  #include ruby::1_9_3
#  #include ruby::2_0_0
#  include ruby::2_0_0_p247
#
#  include virtualbox
#  include vagrant
#  ##vagrant::plugin { 'vagrant-vbguest': }
#
#  include mysql
#  #include postgresql
#
#  include macvim
#  include eclipse::java
#
#  include dropbox
#  include amazonclouddrive
#
#  include redis
#
#  include firefox
#
#  include iterm2::stable
#  include adium
#  include sizeup
#  include gitx::dev
#  include limechat
#  include keepassx
#  include skype
#
#  include gimp
#
#  #include audacity
#  include caffeine
#  include appcleaner
#  include notational_velocity
#  include calibre
#  include kindle
#  include rdio
#
##include textmate::textmate2::release
#include evernote
##include spectacle
##include alfred
##include chrome
#
## from the beta channel
##include chrome::beta
## from the dev channel
##include chrome::dev
## from the nightly channel
##include chrome::canary
## from the chromium continuous build system
##include chrome::chromium
#
##include opera
#
#  #package { 'htop':
#  #  ensure => present,
#  #}
#
#  #package { 'libvirt':
#  #  ensure => present,
#  #}
#
#  #package { 'groovy':
#    #ensure => present,
#  #}
#
#  #package { 'bash-completion':
#  #  ensure => present,
#  #}
#
#  #package { 'phantomjs':
#  #  ensure => present,
#  #}
#
#  file { "/work":
#    ensure => directory,
#  }
#
#  file { "/work/projects":
#    ensure  => directory,
#    require => File["/work"],
#  }
#
#  file { "/work/abd":
#    ensure  => directory,
#    require => File["/work"],
#  }
#
#  file { "/work/unahi":
#    ensure  => directory,
#    require => File["/work"],
#  }
#
#  #file { "/Users/${luser}/Music/iTunes/iTunes Media/Music":
#  #  ensure => link,
#  #  target => "/Users/${luser}/Cloud Drive/Music",
#  #}
#
#  #file { "/Users/${luser}/Music/iTunes/iTunes Library Extras.itdb":
#  #  ensure => link,
#  #  target => "/Users/${luser}/Cloud Drive/Music/iTunes Library Extras.itdb",
#  #}
#
#  #file { "/Users/${luser}/Music/iTunes/iTunes Library Genius.itdb":
#  #  ensure => link,
#  #  target => "/Users/${luser}/Cloud Drive/Music/iTunes Library Genius.itdb",
#  #}
#
#  #file { "/Users/${luser}/Music/iTunes/iTunes Library.itl":
#  #  ensure => link,
#  #  target => "/Users/${luser}/Cloud Drive/Music/iTunes Library.itl",
#  #}
#
#  #file { "/Users/${luser}/Music/iTunes/Music Library.xml":
#  #  ensure => link,
#  #  target => "/Users/${luser}/Cloud Drive/Music/Music Library.xml",
#  #}
#
#  sudoers { 'ID1':
#    users      => "${luser}",
#    hosts      => 'ALL',
#    commands   => '(ALL) NOPASSWD: ALL',
#    comment    => 'pimp my comment',
#    type       => 'user_spec',
#  }
#}
