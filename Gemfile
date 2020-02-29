source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.12'
gem 'pg', '~> 0.18.4'
gem 'dotenv-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Apitome is a API documentation tool for Rails built on top of the great
# rspec DSL included in rspec_api_documentation
gem 'apitome', github: 'jejacks0n/apitome'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
   # Below gem is used for set up database strategy during test cases
  gem 'database_cleaner'
  # below gem is used for create mock data easily for test cases
  gem 'factory_bot_rails'
  # below gem is used for genrating the random data
  gem 'faker'
  gem 'rspec_api_documentation'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'rubocop'
  gem 'rubocop-rspec', '1.27.0'

  # below gem is used to provide the coverage of test cases
  gem 'simplecov'
  # below gem is added to provide the coverage output format in RCOV style.
  gem 'simplecov-rcov'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
