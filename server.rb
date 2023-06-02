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

  before do
    restricted_paths = ['/lobby', '/:category_name/levels', '/:category_name/:level_name/questions']

    if restricted_paths.include?(request.path_info) && !session[:user_id]
      redirect '/showLogin'
    end
    if (request.path_info == '/' || request.path_info == '/showLogin') && session[:user_id]
      redirect '/lobby'
    end
  end

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
      if user.save
        # Redirigir a la página de inicio de sesión
        profile = Profile.new(user_id: user.id, totalPoints: 0)
        profile.save
        record = Record.new(user_id: user.id)
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
    #Categoria actual
    @catLvl = category_using_name(params[:category_name])
    @levelsCat = Level.where(category_id: @@catLvl.id)
    erb :levels
  end

  get '/:category_name/:level_name/questions' do

    @catLvl = category_using_name(params[:category_name])
    @lvl = @catLvl.levels.find_by(name: params[:level_name].capitalize)
    questions = Question.where(level_id = @lvl.id).order("RANDOM()")

    if question.empty?
      redirect "/#{@catLvl.name.downcase}/levels"
    else
      first_question = questions.first
      redirect "/#{@catLvl.name.downcase}/#{@lvl.name.downcase}/questions/#{first_questions.id}"
    end
  end

  get ':category_name/:level_name/questions/:question_id' do
    @catLvl = category_using_name(params[:category_name])
    level = Level.find_by(name: params[:level_name].capitalize)
    question = Question.find(params[:question_id])
    answers = question.select(:answer, :wrongAnswer1, :wrongAnswer2, :wrongAnswer3).to_a.shuffle

    erb :question, locals: {lvl: level, question: question, options: answers}

  end

  post ':category_name/:level_name/questions/:question_id' do

    current_question = Question.find(params[:question_id])
    # Obtener la respuesta enviada por el usuario
    userAnswer = params[:userAnswer]
    # Le doy 0 a points si esta no tiene un valor antes
    penaltyPoint ||= 0
    totalPoint ||= 0

    # Verificar si la respuesta es correcta
    if userAnswer.downcase == current_question.answer.downcase
      @totalPoint += current_question.pointQuestion - penaltyPoint
      
      next_questions = Question.where(level_id: params[:level_id]).where.not(id: params[:question_id]).order("RANDOM()").first
      # Mostrar la siguiente pregunta (si existe)
      if next_questions.empty?
        # Se reinicia los puntos totales ganados
        @totalPoint = 0
        # Se reinicia los puntos penalizados que se tuvo en la prgunta
        penaltyPoint = 0
        # No hay más preguntas, mostrar mensaje de juego completado
        erb :game_completed
      else
        session[:current_question] %= @@questions.size
        next_question = @@questions[session[:current_question]]
        answers_next = [next_question.answer, next_question.wrongAnswer1, next_question.wrongAnswer2, next_question.wrongAnswer3,].shuffle
        session[:options] = answers_next
        # Se reinicia los puntos penalizados que se tuvo en la prgunta
        penaltyPoint = 0;
        erb :question, locals: { question: next_question, options: session[:options]}
      end
    else
      tries += 1
      penaltyPoint -= @@tries * 5
      # La respuesta es incorrecta, volver a mostrar la misma pregunta
      erb :question, locals: { question: current_question, options: session[:options]}
    end
  end

  # METODOS
  def category_using_name (catName)
    return Category.find_by(name: catName.capitalize)
  end


end
