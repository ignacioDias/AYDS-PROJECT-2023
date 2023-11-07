# frozen_string_literal: true

class MainController < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  get '/lobby' do
    @category = Category.all
    @user = User.find(session[:user_id])
    @profile = Profile.find_by(user_id: @user.id)
    erb :lobby
  end

  get '/ranking' do
    @rankings = Ranking.joins(:user).pluck('users.username', 'rankings.points')
    erb :ranking
  end

  get '/:category_name/levels' do
    if session[:user_id]
      @cat_lvl = Category.category_using_name(params[:category_name]) # Categoria actual
      @levels_cat = Level.where(category_id: @cat_lvl.id)
      @levels_ids = RecordLevel.levels_ids_completed(session[:user_id])
      @exam = Exam.find_by(category_id: @cat_lvl.id)
      erb :levels
    else
      redirect '/lobby'
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
    @profile.update(description: params[:description]) if params[:description].present?
    @profile.update(photo: params[:photo_link]) if params[:photo_link].present?
    redirect '/profile'
  end

  get '/:category_name/levels/:level_id/completed' do
    @cat_lvl = Category.category_using_name(params[:category_name])
    @total_points = getPointLevel(params[:level_id])
    erb :game_completed # No hay más preguntas, mostrar mensaje de juego completado
  end

  # METODOS
  def getPointLevel(level_id)
    record = Record.find_by(user_id: session[:user_id])
    record_level = RecordLevel.find_by(record_id: record.id, level_id: level_id)
    record_level.total_points
  end
end
