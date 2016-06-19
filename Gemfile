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
gem 'friendly_id', '5.0.5'   # slugging and permalink plugins for ActiveRecord

# Forum System
gem 'forem',           github: 'radar/forem',           branch: 'rails4'
gem 'forem-bootstrap', github: 'radar/forem-bootstrap', branch: 'master'
gem 'forem-redcarpet', github: 'radar/forem-redcarpet'
gem 'forem-rdiscount'     # Post formatter

# Rails Extensions
gem 'gravtastic'          # User avatars    
gem 'redcarpet', '3.0.0'  # Markdown parser 
gem 'kaminari'            # Pagination
gem 'devise'              # User authentication
gem 'bcrypt'              # Encryption
gem 'mailboxer'           # User messaging

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





# Google Maps
gem 'gmaps4rails'
gem 'geocoder'

# Extra
gem 'rename'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '2.1.3'
  gem 'spring'
  gem 'annotate'
  gem 'figaro'
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', '~> 0.4.0' 
end