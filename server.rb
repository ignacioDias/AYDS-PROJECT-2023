# frozen_string_literal: true

# server.rb
require 'sinatra/base'
require 'sinatra/contrib'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require_relative 'models/index'
require_relative './controllers/index'

class App < Sinatra::Application
  def initialize(_app = nil)
    super()
  end

  # set :root,  File.dirname(__FILE__)
  set :root, File.dirname(__FILE__)
  # set :views, File.expand_path('../views', settings.root)
  set :views, File.expand_path('../views', __FILE__)
  # set :views, proc { File.join(root, '/views') }
  set :public_folder, File.join(root, 'static')

  configure :production, :development do
    enable :logging
    logger = Logger.new($stdout)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      logger.info 'Reloaded'
    end
  end

  enable :sessions

  set :session_expire_after, 7200

  before do
    restricted_paths = ['/lobby', '/profile', '/:category_name/levels', '/:category_name/:level_name/questions']

    redirect '/showLogin' if restricted_paths.include?(request.path_info) && !session[:user_id]
    redirect '/lobby' if (request.path_info == '/' || request.path_info == '/showLogin') && session[:user_id]
  end

  use UsersController
  use MainController
  use ExamController
  use QuestionController
end
