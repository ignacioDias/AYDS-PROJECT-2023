# frozen_string_literal: true

# config/environment.rb
db_options = YAML.safe_load(File.read(File.expand_path('database.yml', __dir__)))

environment = ENV['APP_ENV'] || 'development'
ActiveRecord::Base.establish_connection(db_options[environment])
