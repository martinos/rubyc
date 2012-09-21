source "http://rubygems.org"

# Specify your gem's dependencies in rubyc.gemspec
gemspec

# This part is taken from the thor gem Gemfile file
platforms :mri_18 do
  gem 'ruby-debug', '>= 0.10.3'
end

platforms :mri_19 do
  group :development do
    gem 'ruby-debug19'
  end
end

group :development do
  gem 'pry'
  gem 'guard'
  gem 'guard-minitest'
  gem 'rb-fsevent', '~> 0.9.1'
  # gem 'growl', '1.0.3'
  # gem 'ruby_gntp', '0.3.4'
end
