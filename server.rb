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

  enable :sessions
  set :session_expire_after, 7200

  get '/' do
    erb :inicio
    ##erb :index #mostrar index.erb
  end 

  get '/registro' do
    erb :register
  end

  post '/inicio' do
    erb :inicio
  end

  get '/showLogin' do
    erb :login
  end

  get '/lobby' do
    @category = Category.all
    erb :lobby
  end


  post '/login' do
    user = User.find_by(username: params[:username])
    passInput = params[:password]
    if user.nil?
      @errorUsername = "Username no encontrado"
      redirect '/showLogin' # Redirige al usuario a la página de inicio de sesión
    elsif user.password == passInput
      @errorPassword = "Contraseña incorrecta"
      session[:user_id] = user.id
      redirect '/lobby' # Redirige al usuario al lobby si las contraseñas coinciden
    else
      erb :login
    end
  end

  post '/formulario' do
    # Recuperar los valores de los campos del formulario
    email = params[:email]
    username = params[:username]
    password = params[:password]
    password_confirmation = params[:password_repeat]

    # Verificar que las contraseñas sean iguales
    if password == password_confirmation
      # Las contraseñas coinciden, crear la cuenta
      user = User.new(email: email, username: username, password: password)
      #user.created_at = Time.now
      #user.update_at = Time.now

      if user.save
        # Redirigir a la página de inicio de sesión
        redirect '/showLogin'
      else
        erb :register
      end
    else
      # Las contraseñas no coinciden, mostrar un mensaje de error
      @error = "Las contraseñas no coinciden"
      erb :register
    end
  end

  get '/:category_name/levels' do
    @catName = params[:category_name].capitalize
    catLvl = Category.find_by(name: @catName)
    @levelsCat = Level.where(category_id: catLvl.id)
    erb :levels
  end

  get ':category_name/level_name/questions' do
    lvlName = params[:level_name].capitalize.to_s
    lvlQuestion = Level.find_by(name: lvlName)
    @questionsLvlCat = Question.where(level_id: lvlQuestion.id)
  end

end
