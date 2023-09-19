#server.rb
require 'sinatra/base'
require 'sinatra/contrib'
require 'bundler/setup'
require 'logger'
require "sinatra/activerecord"
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require_relative 'models/index'
require_relative 'routes/get_routes'  # Agrega esta línea
require_relative 'routes/post_routes' # Agrega esta línea

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

  # METODOS
  def levels_ids_completed ()
    user = User.find(session[:user_id])
    record = user.record
    return RecordLevel.where(record_id: record.id).pluck(:level_id)
  end

  def update_points_profile (points)
    profile = Profile.find_by(user_id: session[:user_id])
    new_total = profile.totalPoints + points
    profile.update(totalPoints: new_total)
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
