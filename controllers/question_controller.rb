# frozen_string_literal: true

class QuestionController < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  ## Questions of Levels
  get '/:category_name/levels/:level_id/questions/:question_id' do
    @catLvl = Category.category_using_name(params[:category_name])
    level = Level.find_by(id: params[:level_id])
    question = Question.find_by(id: params[:question_id].to_i)
    answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
    erb :question, locals: { lvl: level, question: question, options: answers }
  end

  get '/:category_name/levels/:level_id/questions' do
    @catLvl = Category.category_using_name(params[:category_name])
    @lvl = @catLvl.levels.find_by(id: params[:level_id])
    questions = Question.where(level_id: @lvl.id).order('RANDOM()')
    if questions.empty?
      redirect to("/#{params[:category_name]}/levels")
    else
      first_question = questions.first

      redirect "/#{params[:category_name]}/levels/#{params[:level_id]}/questions/#{first_question.id}" # el URI.encode es para tratar los espacios y caracteres correctamente
    end
  end

  post '/:category_name/levels/:level_id/questions/:question_id/resp' do
    # @catLvl = Category.category_using_name(params[:category_name])
    current_question = Question.find(params[:question_id])
    level = Level.find_by(id: params[:level_id])
    userAnswer = params[:userAnswer] # Obtener la respuesta enviada por el usuario
    if userAnswer.downcase == current_question.answer.downcase # Verificar si la respuesta es correcta
      answerCorrect(params[:category_name], current_question, level)
    else
      answerIncorrect(params[:category_name], current_question, level)
    end
  end

  # METODOS
  def answerCorrect(cat_name, current_question, level)
    current_point = current_question.pointQuestion # Cargo el registro de la pregunta completado
    RecordQuestion.add_record_question(session[:user_id], params[:level_id], current_question, current_point, true)
    Profile.update_points_profile(current_point, session[:user_id]) # actualizo los puntos en el perfil
    quest_next = Question.next_question(session[:user_id], level.id, current_question.id) # Siguiente pregunta
    if quest_next.nil?
      RecordLevel.add_record_level(level, session[:user_id]) # Agrego el registro del level completado
      redirect "/#{cat_name}/levels/#{level.id}/completed"
    else
      redirect "/#{cat_name}/levels/#{level.id}/questions/#{quest_next.id}" # Se reinicia los puntos penalizados que se tuvo en la prgunta
    end
  end

  def answerIncorrect(cat_name, current_question, level)
    RecordQuestion.add_record_question(session[:user_id], level.id, current_question, -5, false)
    Profile.update_points_profile(-5, session[:user_id]) # actualizo los puntos en el perfil
    question = Question.find(current_question.id)
    [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
    redirect "/#{cat_name}/levels/#{level.id}/questions/#{current_question.id}" # La respuesta es incorrecta, volver a mostrar la misma pregunta
  end
end
