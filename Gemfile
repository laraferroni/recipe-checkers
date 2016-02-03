source 'https://rubygems.org'


group :server, :default do
  gem 'rails', '4.1.9'
  gem 'pg'
  gem 'unicorn'
  gem 'dotenv-rails'
  gem 'sidekiq'
  gem 'sinatra' # for sidekiq web console
  gem 'puma'
  gem 'route_downcaser'
  gem 'rails_12factor', group: :production
end

group :auth, :default do
  gem 'cancan'
  gem 'devise'
  gem 'devise-async'
  gem 'omniauth-facebook'
  gem 'omniauth-google-oauth2'
  gem 'omniauth-twitter'
  gem 'twitter'
end

group :asset, :default do
  gem 'haml-rails'
  gem 'sass-rails', '~> 5.0.0' # Use SCSS for stylesheets
  gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
  gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
  gem 'jquery-rails' # Use jquery as the JavaScript library
  gem 'jquery-turbolinks' # Use to fix flakey turbolink/jquery interactions
  gem 'turbolinks' # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  
  gem 'jquery-ui-rails'
  gem 'foundation-rails'
  gem 'foundation-icons-sass-rails'
  gem 'foundation_rails_helper'
  gem 'twitter-typeahead-rails'
  gem "jquery-slick-rails"
  gem 'font-awesome-sass', '~> 4.5.0'
  gem 'gravatar_image_tag'
  gem 'useragent'
  gem 'will_paginate'
  gem 'premailer-rails'
  gem 'paperclip', ['>= 3.4', '!= 4.3.0']
  gem 'aws-sdk', '~> 1.5.7'
  gem 'remotipart', '~> 1.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby
end

group :api, :default do
  gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'active_model_serializers'
end

group :admin, :default do
  gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
end

group :development, :default do
  gem 'better_errors'
  gem 'binding_of_caller'  
end

group :doc do
  gem 'sdoc', require: false # bundle exec rake doc:rails generates the API under doc/api.
end


# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
#gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


