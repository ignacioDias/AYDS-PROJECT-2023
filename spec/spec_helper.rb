require 'sinatra/base'
require 'sinatra/activerecord'
require 'simplecov'
require 'database_cleaner'

SimpleCov.start

  ENV['RACK_ENV'] ||= 'test'
  ENV['APP_ENV'] ||= 'test'

  ActiveRecord::Base.logger.level = 1

  require File.expand_path('../../config/environment.rb', __FILE__)

  RSpec.configure do |config|
    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

    config.shared_context_metadata_behavior = :apply_to_host_groups

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.around(:each) do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end
  end
