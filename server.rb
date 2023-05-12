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
   set :root,  File.dirname(__FILE__)
   set :views, Proc.new { File.join(root, 'views') }
   set :public_folder, File.join(root, 'static')

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
    erb :index #mostrar index.erb
  end

  post '/formulario' do
    @user = User.find_or_create_by(email: params[:email], password: params[:password])
    erb :user #mostrar user
  end




end
