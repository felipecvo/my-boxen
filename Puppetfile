# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

def github(name, version, options = nil)
  options ||= {}
  options[:repo] ||= "boxen/puppet-#{name}"
  mod name, version, :github_tarball => options[:repo]
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.3.4"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

##github "dnsmasq",    "1.0.0"
##github "gcc",        "2.0.1"
#github "git",        "1.2.5"
github "homebrew",   "1.6.0"
##github "hub",        "1.0.0"
#github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
##github "nginx",      "1.4.0"
##github "nodejs",     "2.2.0"
github "repository", "2.2.0"
#github "ruby",       "5.2.1"
#github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
#github "xquartz",    "1.1.1"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

#github "macvim",           "1.0.0"
#github "wget",             "1.0.0"
#github "dropbox",          "1.1.0"
#github "iterm2",           "1.0.2"
#github "adium",            "1.1.1"
##github "sizeup",           "1.0.0"
#github "gitx",             "1.2.0"
#github "amazonclouddrive", "1.0.0", :repo => "felipecvo/puppet-amazonclouddrive"
#github "limechat",         "1.2.0", :repo => "dieterdemeyer/puppet-limechat"
##github "audacity",         "2.0.3", :repo => "felipecvo/puppet-audacity"
#github "caffeine",         "1.0.0"
#github "mysql",            "1.1.1"
#github "firefox",          "1.1.0"
#github "keepassx",         "1.0.0"
##github "postgresql",       "1.0.0"
#github "virtualbox",       "1.0.5"
#github "vagrant",          "2.0.12"
#github "gimp",             "1.0.0"
#github "appcleaner",       "1.0.0"
#github "skype",            "1.0.4"
#github "redis",            "1.0.0"
#
#github "notational_velocity", "1.1.1"
#
##github "shiftit",          "0.0.2"
#github "calibre",          "1.1.0", :repo => "felipecvo/puppet-calibre"
#github "dashlane",         "1.0.1"
#github "rdio",             "1.0.0"
#github "kindle",           "1.0.1"
#github "sparrow",          "1.0.0"
#github "eclipse",          "2.1.0"
#github "steam",            "1.0.1"
