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
    @user = User.find(session[:user_id])
    @profile = Profile.find_by(user_id: @user.id)
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
      @user = User.new(email: email, username: username, password: password)
      if @user.save
        profile = Profile.new(user_id:  @user.id, totalPoints: 0)
        profile.save
        record = Record.new(user_id: @user.id)
        record.save

        # Redirigir a la página de inicio de sesión
        redirect '/showLogin'
      else
        erb :register
      end
    else
      # Las contraseñas no coinciden, mostrar un mensaje de error
      @error = "passwords don't match"
      erb :register
    end
  end

  get '/:category_name/levels' do
    #Categoria actual
    @catLvl = category_using_name(params[:category_name])
    @levelsCat = Level.where(category_id: @catLvl.id)
    erb :levels
  end

  get '/:category_name/levels/:level_id/questions/:question_id' do
    @catLvl = category_using_name(params[:category_name])
    level = Level.find_by(id: params[:level_id])
    question = Question.find_by(id: params[:question_id].to_i)
    answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
    erb :question, locals: {lvl: level, question: question, options: answers}
  end

  get '/:category_name/levels/:level_id/questions' do
    @catLvl = category_using_name(params[:category_name])
    @lvl = @catLvl.levels.find_by(id: params[:level_id])
    questions = Question.where(level_id:  @lvl.id).order("RANDOM()")
    if questions.empty?
      redirect to("/#{params[:category_name]}/levels")
    else
      first_question = questions.first
      #el URI.encode es para tratar los espacios y caracteres correctamente
      redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{first_question.id}"
    end
  end

  
  post '/:category_name/levels/:level_id/questions/:question_id/resp' do
    @catLvl = category_using_name(params[:category_name])
    current_question = Question.find(params[:question_id])
    level = Level.find_by(id: params[:level_id])
    # Obtener la respuesta enviada por el usuario
    userAnswer = params[:userAnswer]
    # Le doy 0 a points si esta no tiene un valor antes
    penaltyPoint ||= 0
    tries ||= 0

    # Verificar si la respuesta es correcta
    if userAnswer.downcase == current_question.answer.downcase
      # Cargo el registro de la pregunta completado
      current_point = current_question.pointQuestion - penaltyPoint
      add_record_question(current_question, current_point, tries)

      # Siguiente pregunta
      quest_next = next_question(level.id, current_question.id)

      if quest_next.nil?
        # Se reinicia los puntos penalizados que se tuvo en la prgunta
        penaltyPoint = nil
        tries = nil
        # Agrego el registro del level completado y devuelvo el total de puntos
        @totalPoints = add_record_level(level)
        #actualizo los puntos en el perfil
        update_points_profile(@totalPoints)
        # No hay más preguntas, mostrar mensaje de juego completado
        erb :game_completed
      else
        # Se reinicia los puntos penalizados que se tuvo en la prgunta
        penaltyPoint = nil
        tries = nil
        redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{quest_next.id}"
      end
    else
      tries += 1
      penaltyPoint -= tries * 5
      question = Question.find(params[:question_id])
      answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
      # La respuesta es incorrecta, volver a mostrar la misma pregunta
      erb :question, locals: {lvl: level, question: question, options: answers}
    end
  end

  # METODOS
  #
  def update_points_profile (points)
    profile = Profile.find(session[:user_id])
    new_total = profile.totalPoints + points
    profile.update(totalPoints: new_total)
  end

  def category_using_name (catName)
    return Category.find_by(name: catName.capitalize)
  end

  def next_question (level_id, current_question_id)
    questions = Question.where(level_id: level_id).to_a.shuffle
    user = User.find(session[:user_id])
    record = user.record
    record_questions_user = RecordQuestion.where(record_id: record.id)
    question_ids = record_questions_user.joins(:question).where(questions: { level_id: level_id }).pluck(:question_id)

    questions.each do |q|
      unless question_ids.include?(q.id)
        return q
      end
    end
    return nil
  end

  def add_record_question (current_question, current_point_question, tries)
    user = User.find_by(id: session[:user_id])
    record = user.record
    record_question = RecordQuestion.new(record_id: record.id, question_id: current_question.id, points: current_point_question, tries: tries)
    record_question.save
  end

  def add_record_level (level)
    user = User.find(session[:user_id])
    record = user.record
    records_questions = record.record_questions.to_a
    score = 0
    total_tries = 0
    records_questions.each do |rq|
      level_question = Question.find_by(id: rq.question_id).level
      if level_question.id == level.id
        score += rq.points
        total_tries += rq.tries
      end
    end
    record_level = RecordLevel.new(record_id: record.id, level: level, total_points: score, total_tries: total_tries)
    record_level.save
    return score
  end

end
