source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "dartsass-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

gem "govuk_publishing_components"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rubocop-govuk", require: false
end

group :development do
  gem "web-console"
end
