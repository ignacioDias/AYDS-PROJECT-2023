# server.rb
require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require "sinatra/activerecord"
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require_relative 'models/index'

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
    erb :inicio
    ##erb :index #mostrar index.erb
  end 

  get '/registro' do
    erb :index
  end

  post '/inicio' do
    erb :inicio
  end

  get '/showLogin' do
    erb :login
  end
  
  post '/login' do
    @user = User.find_or_create_by(username: params[:username], password: params[:password])
    redirect '/'
  end

  post '/formulario' do
   # @user = User.find_or_create_by(username: params[:username], email: params[:email], password: params[:password])
    #redirect '/'
    # Recuperar los valores de los campos del formulario
    email = params[:email]
    username = params[:username]
    password = params[:password]
    password_confirmation = params[:password_repeat]

    # Verificar que las contraseñas sean iguales
    if password == password_confirmation
      # Las contraseñas coinciden, crear la cuenta
      user = User.create(email: email, username: username, password: password)
      # Redirigir a la página de inicio de sesión
      redirect '/showLogin'
    else
      # Las contraseñas no coinciden, mostrar un mensaje de error
      @error = "Las contraseñas no coinciden"
      erb :index
    end
  end

end
