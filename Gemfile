source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'jwt', '~> 2.3'

gem 'active_model_serializers', '~> 0.10'
gem 'virtus', '~> 2.0'
gem 'sidekiq', '~> 6.3'

gem 'paranoia', '~> 2.5'
gem 'paper_trail', '~> 12.2'
gem 'strip_attributes', '~> 1.12'
gem 'validates_timeliness', '~> 5.0'
# Plugin for versioning Rails based RESTful APIs
gem 'versionist', '~> 2.0'

# Support for payments
gem 'stripe', '~> 5.44'

gem 'rack-cors', '~> 1.1'

# Support AWS
gem 'aws-sdk-sqs', '~> 1.51'
# gem 'aws-sdk', '~> 3.1'

gem 'sassc-rails'

# Support for search
gem 'ransack', '~> 2.5'

# Suport pagination
gem 'kaminari', '~> 1.2'

# Support for upload file
gem 'shrine', '~> 3.4'
gem "aws-sdk-s3", "~> 1.14"
gem 'aws-sdk-dynamodb', '~> 1.7'

# Firebasse push notification
gem 'fcm', '~> 1.0'

gem 'activerecord-import'

# Push notification to slack
gem 'slack-notifier', '~> 2.4'

gem 'exception_notification', '~> 4.5'

gem 'seed-fu', '~> 2.3'

# Support postal code JP
gem 'zip_code_jp', '~> 0.0.6'

# Support authorize
gem 'pundit', '~> 2.2'

gem 'open-weather-ruby-client', '~> 0.2.0'

gem 'news-api', '~> 0.2.0'

# Support for render pdf
gem 'pdfkit', '~> 0.8.6'
gem 'render_anywhere', '~> 0.0.12'
# gem 'wkhtmltopdf-binary', '~> 0.12.6.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Support export pdf files
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# # HTTP/REST API client library
# gem 'faraday', '~> 2.6'
gem 'xml-simple'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bullet', '~> 7.0'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'pry-byebug', '~> 3.9.0', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.1'
  gem 'faker', '~> 2.19'
  gem 'dotenv-rails', '~> 2.7'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'annotate', '~> 3.1'
  gem 'better_errors', '~> 2.9'
  gem 'brakeman', '~> 5.2'
  gem 'letter_opener', '~> 1.7'
  gem 'rubocop', '~> 1.24'
  gem 'rails_best_practices', '~> 1.23'
end

group :test do
  gem 'shrine-memory'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'database_cleaner'

  ### Analysis ###
  gem 'simplecov', '~> 0.21', require: false
  gem 'simplecov-json', '~> 0.2.3'

    ### CI ###
  gem 'danger'                      # Like Unit Tests, but for your Team Culture.
  gem 'danger-rubocop'              # A Danger plugin for running Ruby files through Rubocop.
  gem 'danger-rails_best_practices' # A Danger plugin to lint Ruby files through rails_best_practices.
  gem 'danger-reek'                 # A Danger plugin to lint Ruby files through Reek.
  gem 'danger-slim_lint'            # A Danger plugin to lint Ruby files through slim-lint.
  gem 'danger-simplecov_json'       # A Danger plugin to report code coverage generated by SimpleCov in JSON format.
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
