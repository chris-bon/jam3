source 'https://rubygems.org'
ruby '2.3.1'

# Required
gem 'rails',   '4.2.6'
gem 'bundler', '1.12.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin]  # Windows compatibility

# Database
gem 'pg', '~> 0.15'          # Postgres plug-in for Rails
gem 'seed_dump'              # database dumper
gem 'faker'                  # random data generator
gem 'factory_girl_rails'     # create factories
gem 'friendly_id', '5.0.5'   # slugging and permalink plugins for ActiveRecord

# JavaScript
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder',     '~> 2.0'
gem 'underscore-rails'

# Bootstrap and CSS Themes
gem 'sass-rails',   '~> 5.0'
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-sass'
gem 'autoprefixer-rails'
gem 'babel-source'

# User Authentication
gem 'devise'         
gem 'bcrypt'            

# User Avatars:  Profile <-{ Images }
gem 'gravtastic'

# Messager
gem 'mailboxer' 

# Search Engine
gem 'sunspot_rails'

# Forum System
gem 'thredded', '~> 0.6.1'

# Pagination
gem 'kaminari'

# Google Maps
gem 'gmaps4rails'
gem 'geocoder'

# Extra
gem 'rename'
gem 'redcarpet', '3.0.0'  # Markdown parser
gem 'simple_form'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '2.1.3'
  gem 'spring'
  gem 'annotate'
  gem 'figaro'
  gem 'rubocop'
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', '~> 0.4.0' 
end