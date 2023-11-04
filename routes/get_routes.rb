# frozen_string_literal: true

# routes/get_routes.rb
class MyAppGet < Sinatra::Base
  include App::MyHelpers
  helpers MyHelpers

  get '/' do
    erb :inicio # erb :index #mostrar index.erb
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

  get '/:category_name/levels' do
    @catLvl = category_using_name(params[:category_name]) # Categoria actual
    @levelsCat = Level.where(category_id: @catLvl.id)
    @levels_ids = levels_ids_completed
    erb :levels
  end

  get '/:category_name/levels/:level_id/questions/:question_id' do
    @catLvl = category_using_name(params[:category_name])
    level = Level.find_by(id: params[:level_id])
    question = Question.find_by(id: params[:question_id].to_i)
    answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
    erb :question, locals: { lvl: level, question: question, options: answers }
  end

  get '/:category_name/levels/:level_id/questions' do
    @catLvl = category_using_name(params[:category_name])
    @lvl = @catLvl.levels.find_by(id: params[:level_id])
    questions = Question.where(level_id: @lvl.id).order('RANDOM()')
    if questions.empty?
      redirect to("/#{params[:category_name]}/levels")
    else
      first_question = questions.first

      redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{first_question.id}" # el URI.encode es para tratar los espacios y caracteres correctamente
    end
  end

  get '/ranking' do
    @rankings = Ranking.all.order(points: :desc)
    erb :ranking
  end
end
