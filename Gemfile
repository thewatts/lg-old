source 'https://rubygems.org'

gem 'rails', '4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'jquery-rails'             # Use jquery as the JavaScript library
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'sass-rails', '~> 4.0.0'   # Use SCSS for stylesheets
gem 'haml'                     # HAML Markup Language for views
gem 'pg'                       # Postgresql Database

gem 'dynamic_form'

gem 'jazz_hands' # pry / pp / hirb

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

group :development, :test do
  gem 'figaro'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', require: false
  gem 'rack_session_access'
end

group :production do
  gem 'rails_12factor'
end
