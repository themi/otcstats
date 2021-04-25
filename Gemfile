source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.1'
# gem 'sqlite3'
gem 'puma', '~> 5.0'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'simple_form'
# gem 'bootstrap_autocomplete_input'

gem 'browser'  # https://github.com/fnando/browser

gem 'devise'
# gem 'pundit'
# gem 'image_processing', '~> 1.2'

gem "ops_care", path: "/Users/themi/projects/reinteractive/OpsCare" #git: "git@github.com:reinteractive/OpsCare.git", branch: "master"
gem "ffaker"

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem "annotate"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem "dotenv-rails"
  gem "factory_bot_rails"
end

group :test do
  gem "capybara"
  gem "webdrivers"
  gem "simplecov", require: false
end
