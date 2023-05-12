# server.rb
require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require "sinatra/activerecord"
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require_relative 'models/user'
require_relative 'models/profile'
require_relative 'models/question'

class App < Sinatra::Application

  def initialize(app = nil)
    super()
  end
  configure :production, :development do
    enable :logging

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end
  
  configure :development do
    register Sinatra::Reloader
    after_reload do
      logger.info 'Reloaded'
    end
  end

  get '/' do
    'Welcome'
  end
end
