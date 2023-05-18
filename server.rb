# server.rb
require 'sinatra/base'
require 'sinatra/contrib'
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
    @@catName = params[:category_name].capitalize
    catLvl = Category.find_by(name: @@catName)
    @levelsCat = Level.where(category_id: catLvl.id)
    erb :levels
  end

  get '/:category_name/:level_name/questions' do
    # Obtener el nivel y las preguntas del mismo
    lvl_name = params[:level_name].capitalize.to_s
    @@lvl = Level.find_by(name: lvl_name)
    questions = Question.where(level_id: @@lvl.id).to_a.shuffle

    # Guardar las preguntas en la sesión y mostrar la primera pregunta
    session[:questions] = questions
    session[:current_question] = 0
    answers = [questions[0].answer, questions[0].wrongAnswer1, questions[0].wrongAnswer2, questions[0].wrongAnswer3,].shuffle
    session[:options] = answers
    erb :question, locals: { question: questions[0], options: session[:options]}
  end

  post '/:category_name/:level_name/questions' do
    # Obtener la respuesta enviada por el usuario
    userAnswer = params[:userAnswer]

    # Verificar si la respuesta es correcta
    current_question = session[:questions][session[:current_question]]
    if userAnswer.downcase == current_question.answer.downcase
      # La respuesta es correcta, eliminar la pregunta actual de la lista
      session[:questions].delete_at(session[:current_question])

      # Mostrar la siguiente pregunta (si existe)
      if session[:questions].empty?
        # No hay más preguntas, mostrar mensaje de juego completado
        erb :game_completed
      else
        session[:current_question] %= session[:questions].size
        next_question = session[:questions][session[:current_question]]
        answers_next = [next_question.answer, next_question.wrongAnswer1, next_question.wrongAnswer2, next_question.wrongAnswer3,].shuffle
        session[:options] = answers_next
        erb :question, locals: { question: next_question, options: session[:options]}
      end
    else
      # La respuesta es incorrecta, volver a mostrar la misma pregunta
      erb :question, locals: { question: current_question, options: session[:options]}
    end
  end


end
