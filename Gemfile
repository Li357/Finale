# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 6.0.0"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
gem "tiny_tds", "~> 2.1"
gem "sequel", "~> 5.27"
# Use Puma as the app server
gem "puma", "~> 3.11"

gem "graphql", "~> 1.9.14"
gem "graphql-extras", "~> 0.2.4"
gem "jwt", "~> 2.2.1"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
gem "bcrypt", "~> 3.1.7"

# Use Active Storage variant
# gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  gem 'sprockets', '~> 3'
  gem "graphiql-rails"

  # gem "faker"
  gem "rubocop", "~> 0.75.1"
  gem "rubocop-rails_config", "~> 0.7.3"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "activerecord-import", "~> 1.0"

gem "roo", "~> 2.8"
