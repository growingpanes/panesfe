source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>4.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', groups: [:development, :test]
gem 'pg', group: :production
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn', group: :production

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# for config file
gem 'inifile', '~>3.0.0'

# authn/authz stuff
gem 'devise', '~>3.4'
gem 'omniauth', '~>1.2'
gem 'omniauth-google-oauth2', '~>0.2'
gem 'pundit', '1.0.0'

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails", '~>3.2.2'

gem 'rubyzip', require: 'zip' # for unzipping foldershows

group :test do
  gem 'rspec-rails', '~>3.1'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capybara'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov', :require => false
  gem 'poltergeist'
  gem 'database_cleaner'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'pry-rails'
end

gem 'dotenv-rails', groups: [:development, :test]
gem 'pry-byebug', groups: [:development, :test]

gem 'delayed_job_active_record'
gem 'rest-client'

gem 'carrierwave'
gem 'carrierwave-mimetype-fu'
gem 'mini_magick'
gem 'streamio-ffmpeg'
gem 'jquery-ui-rails'
gem 'ranked-model'
gem 'will_paginate-bootstrap'
