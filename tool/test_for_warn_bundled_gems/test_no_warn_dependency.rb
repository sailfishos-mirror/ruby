require "bundler"
Bundler::Definition.no_lock = true

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "activesupport", "7.0.7.2"
  gem "bigdecimal"
  gem "mutex_m"
end

require "active_support/all"
