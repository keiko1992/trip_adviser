source 'https://rubygems.org'
ruby '2.2.4'
gem 'rails', '4.2.5'



group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'puma'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '2.8.0', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'sqlite3'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'bullet'
  gem 'erb2haml' # run 'bundle exec rake haml:replace_erbs'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end

# Frontend
gem "autoprefixer-rails"
gem 'coffee-rails', '~> 4.1.0'
gem 'compass-rails', github: "Compass/compass-rails"
gem 'font-awesome-rails'
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Authentification and Security
gem 'bcrypt', '~> 3.1.7'
gem 'cancancan'
gem 'devise'

# Image upload
gem "paperclip", "~> 4.3"
gem 'aws-sdk', '< 2.0'

# PV ranking
gem 'redis', '~>3.2'
gem 'redis-namespace'

# Miscellaneous stuffs
gem 'bower-rails', '~> 0.10.0'
gem 'config'
gem 'friendly_id', '~> 5.1.0'
gem 'jbuilder', '~> 2.0'
gem 'kaminari'
gem "meta-tags"
gem 'paranoia', '~> 2.0'
gem 'ransack'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'seed-fu', '~> 2.3'
