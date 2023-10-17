#server.rb
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
    restricted_paths = ['/lobby', '/profile', '/:category_name/levels', '/:category_name/:level_name/questions']

    if restricted_paths.include?(request.path_info) && !session[:user_id]
      redirect '/showLogin'
    end
    if (request.path_info == '/' || request.path_info == '/showLogin') && session[:user_id]
      redirect '/lobby'
    end
  end

  get '/' do
    erb :inicio #erb :index #mostrar index.erb
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

  post '/logout' do
    session.clear
    redirect '/'
  end
  
  get '/ranking' do
    @rankings = Ranking.joins(:user).pluck('users.username', 'rankings.points')
    erb :ranking
  end

  get '/:category_name/levels' do
    if session[:user_id]
      @catLvl = category_using_name(params[:category_name])#Categoria actual
      @levelsCat = Level.where(category_id: @catLvl.id)
      @levels_ids = levels_ids_completed()
      @exam = Exam.find_by(category_id: @catLvl.id)
      erb :levels
    else
      redirect '/lobby'
    end
  end

  ## Questions of Levels
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
        
        redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{first_question.id}" #el URI.encode es para tratar los espacios y caracteres correctamente
    end
  end

  post '/:category_name/levels/:level_id/questions/:question_id/resp' do
    @catLvl = category_using_name(params[:category_name])
    current_question = Question.find(params[:question_id])
    level = Level.find_by(id: params[:level_id])
    userAnswer = params[:userAnswer]# Obtener la respuesta enviada por el usuario
    if userAnswer.downcase == current_question.answer.downcase # Verificar si la respuesta es correcta
      current_point = current_question.pointQuestion # Cargo el registro de la pregunta completado
      add_record_question(params[:level_id], current_question, current_point, true)
      update_points_profile(current_point) #actualizo los puntos en el perfil
      quest_next = next_question(level.id, current_question.id) # Siguiente pregunta
      if quest_next.nil?
        add_record_level(level) # Agrego el registro del level completado
        redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/completed"
      else
        redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{quest_next.id}" # Se reinicia los puntos penalizados que se tuvo en la prgunta
      end
    else
      add_record_question(params[:level_id], current_question, -5, false)
      update_points_profile(-5) #actualizo los puntos en el perfil
      question = Question.find(params[:question_id])
      answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
      redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{params[:question_id]}" # La respuesta es incorrecta, volver a mostrar la misma pregunta
    end
  end

  get '/:category_name/levels/:level_id/completed' do
    @catLvl = category_using_name(params[:category_name])
    @totalPoints = getPointLevel(params[:level_id])
    erb :game_completed # No hay más preguntas, mostrar mensaje de juego completado
  end


  ##Questions of Exams

  get '/:category_name/levels/exam/:exam_id/questions/:question_id' do
    @catLvl = category_using_name(params[:category_name])
    question = Question.find_by(id: params[:question_id].to_i)
    exam = Exam.find(params[:exam_id])
    answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
    erb :question_exam, locals: {exam: exam, question: question, options: answers}
  end

  get '/:category_name/levels/exam/:exam_id/questions' do
    @catLvl = category_using_name(params[:category_name])
    questions = Question.where(exam_id:  params[:exam_id]).order("RANDOM()").pluck(:id)
    session[:questions_exam] = questions #Guardo el id de las preguntas
    if questions.empty?
        redirect to("/#{params[:category_name]}/levels")
    else
        first_question = questions.first
        
        redirect "/#{params[:category_name]}/levels/exam/#{params[:exam_id]}/questions/#{first_question}" #el URI.encode es para tratar los espacios y caracteres correctamente
    end
  end

  get '/:category_name/levels/exam/:exam_id/completed' do
    @catLvl = category_using_name(params[:category_name])
    exam = RecordExam.find_by(exam_id: params[:exam_id])
    @totalPoints = exam.point
    erb :exam_completed # No hay más preguntas, mostrar mensaje de juego completado
  end

  get '/:category_name/levels/exam/:exam_id/fail' do
    @catLvl = category_using_name(params[:category_name])
    erb :exam_fail
  end

  post '/:category_name/levels/exam/:exam_id/questions/:question_id/resp' do
    @catLvl = category_using_name(params[:category_name])
    current_question = Question.find(params[:question_id])
    userAnswer = params[:userAnswer]# Obtener la respuesta enviada por el usuario
    if userAnswer.downcase == current_question.answer.downcase # Verificar si la respuesta es correcta
      session[:questions_exam].delete(current_question.id) # Siguiente pregunta
      quest_next = session[:questions_exam].sample
      if quest_next.nil?
        exam_finished(@catLvl, params[:exam_id])
        redirect "/#{params[:category_name]}/levels/exam/#{params[:exam_id]}/completed"
      else
        redirect "/#{params[:category_name]}/levels/exam/#{params[:exam_id]}/questions/#{quest_next}"
      end
    else
      redirect "/#{params[:category_name]}/levels/exam/#{params[:exam_id]}/fail" # La respuesta es incorrecta, Repetir el examen
    end
  end



  get '/profile' do
    @user = User.find(session[:user_id])
    @profile = Profile.find_by(user_id: @user.id)
    erb :profile
  end

  post '/profile' do
    @user = User.find(session[:user_id])
    @profile = Profile.find_by(user_id: @user.id)
    if params[:description].present?
      @profile.update(description: params[:description])
    end
    if params[:photo_link].present?
      @profile.update(photo: params[:photo_link])
    end
    redirect '/profile'
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
    email = params[:email]
    username = params[:username]
    password = params[:password]
    password_confirmation = params[:password_repeat]
    if password == password_confirmation # Verificar que las contraseñas sean iguales
      @user = User.new(email: email, username: username, password: password) # Las contraseñas coinciden, crear la cuenta
      if @user.save
        profile = Profile.new(user_id:  @user.id, totalPoints: 0)
        profile.save
        record = Record.new(user_id: @user.id)
        record.save
        ranking = Ranking.new(user_id: @user.id, points: 0)
        ranking.save
        redirect '/showLogin'  # Redirigir a la página de inicio de sesión
      else
        erb :register
      end
    else
      @error = "passwords don't match" # Las contraseñas no coinciden, mostrar un mensaje de error
      erb :register
    end
  end



  # METODOS

    def exam_finished (cat, exam_id)
      record = Record.find_by(user_id: session[:user_id])
      points_exam = complete_levels(cat)
      exam = Exam.find(exam_id)
      record_exam = RecordExam.create(record_id: record.id, exam_id: exam.id, point: points_exam)
      update_points_profile(points_exam)
    end

    def complete_levels (cat)
      levels = Level.where(category_id: cat.id)
      points = 0
      levels.each do |lvl|
        unless RecordLevel.exists?(level_id: lvl.id)
          questions = Question.where(level_id: lvl.id)
          questions.each do |q|
            add_record_question(lvl.id, q, q.pointQuestion, true)
            points += q.pointQuestion
          end
          add_record_level(lvl)
        end
      end
      return points
    end

    def getPointLevel (level_id)
      record = Record.find_by(user_id: session[:user_id])
      record_level = RecordLevel.find_by(record_id: record.id, level_id: level_id)
      return record_level.total_points
    end

    def levels_ids_completed ()
      user = User.find(session[:user_id])
      record = user.record
      return RecordLevel.where(record_id: record.id).pluck(:level_id)
    end

    def update_points_profile (points)
      profile = Profile.find_by(user_id: session[:user_id])
      new_total = profile.totalPoints + points
      profile.update(totalPoints: new_total)
      ranking = Ranking.find_by(user_id: session[:user_id])
      ranking.update(points: new_total)
    end

    def category_using_name (cat_name)
      return Category.find_by(name: cat_name.capitalize)
    end

    def level_using_name (cat_name, level_name)
      category = category_using_name(cat_name)
      return Level.find(category_id: category.id).where(name: level_name)
    end

    def next_question (level_id, current_question_id)
      questions = Question.where(level_id: level_id).to_a.shuffle
      user = User.find(session[:user_id])
      record = user.record
      record_questions_user = RecordQuestion.where(record_id: record.id, wrong: true)
      question_ids = record_questions_user.joins(:question).where(questions: { level_id: level_id }).pluck(:question_id)

      questions.each do |q|
        unless question_ids.include?(q.id)
          return q
        end
      end
      return nil
    end

    def add_record_question (level_id, current_question, current_point_question, is_correctly)
      user = User.find_by(id: session[:user_id])
      record = user.record
      record_questions_user = RecordQuestion.where(record_id: record.id)
      question_ids = record_questions_user.where(wrong: true).joins(:question).where(questions: { level_id: level_id }).pluck(:question_id)
      if (is_correctly)
        unless(question_ids.include?(current_question.id)) #Verifico que no se registren 2 veces una respuesta correcta (SE PODRIA SOLUCIONAR CON VALIDACIONES)
          record_question = RecordQuestion.new(record_id: record.id, question_id: current_question.id, points: current_point_question)
          record_question.save
        end
      else
        record_question = RecordQuestion.new(record_id: record.id, question_id: current_question.id, points: current_point_question, wrong: false)
        record_question.save
      end
    end

    def add_record_level (level)
      user = User.find(session[:user_id])
      record = user.record
      records_questions = record.record_questions
      question_ids = records_questions.joins(:question).where(questions: { level_id: level }).pluck(:question_id)
      score = 0
      records_questions.to_a.each do |rq|
        level_question = Question.find_by(id: rq.question_id).level
        if level_question.id == level.id
          score += rq.points
        end
      end
      record_level = RecordLevel.new(record_id: record.id, level: level, total_points: score)
      record_level.save
    end
end
