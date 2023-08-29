# config/environment.rb
db_options = YAML.load(File.read(File.expand_path('../database.yml', __FILE__)))

environment = ENV['APP_ENV'] || 'development'
ActiveRecord::Base.establish_connection(db_options[environment])

