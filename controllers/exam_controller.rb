# frozen_string_literal: true

class ExamController < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  get '/:category_name/levels/exam/:exam_id/questions/:question_id' do
    @cat_lvl = Category.category_using_name(params[:category_name])
    question = Question.find_by(id: params[:question_id].to_i)
    exam = Exam.find(params[:exam_id])
    answers = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3].shuffle
    erb :question_exam, locals: { exam: exam, question: question, options: answers }
  end

  get '/:category_name/levels/exam/:exam_id/questions' do
    @cat_lvl = Category.category_using_name(params[:category_name])
    questions = Question.where(exam_id:  params[:exam_id]).order('RANDOM()').pluck(:id)
    session[:questions_exam] = questions # Guardo el id de las preguntas
    if questions.empty?
      redirect to("/#{params[:category_name]}/levels")
    else
      first_question = questions.first
      redirect "/#{params[:category_name]}/levels/exam/#{params[:exam_id]}/questions/#{first_question}" # el URI.encode es para tratar los espacios y caracteres correctamente
    end
  end

  get '/:category_name/levels/exam/:exam_id/completed' do
    record = Record.find_by(user_id: session[:user_id])
    @cat_lvl = Category.category_using_name(params[:category_name])
    exam = RecordExam.find_by(record_id: record.id, exam_id: params[:exam_id])
    @total_points = exam.point
    erb :exam_completed # No hay más preguntas, mostrar mensaje de juego completado
  end

  get '/:category_name/levels/exam/:exam_id/fail' do
    @cat_lvl = Category.category_using_name(params[:category_name])
    erb :exam_fail
  end

  post '/:category_name/levels/exam/:exam_id/questions/:question_id/resp' do
    @cat_lvl = Category.category_using_name(params[:category_name])
    current_question = Question.find(params[:question_id])
    user_answer = params[:user_answer] # Obtener la respuesta enviada por el usuario
    if user_answer.downcase == current_question.answer.downcase # Verificar si la respuesta es correcta
      answerCorrect(@cat_lvl, current_question, params[:exam_id])
    else
      redirect "/#{params[:category_name]}/levels/exam/#{params[:exam_id]}/fail" # La respuesta es incorrecta, Repetir el examen
    end
  end

  # METODOS
  def answerCorrect(cat_level, current_question, exam_id)
    session[:questions_exam].delete(current_question.id) # Siguiente pregunta
    quest_next = session[:questions_exam].sample
    if quest_next.nil?
      exam_finished(cat_level, exam_id)
      redirect "/#{cat_level.name}/levels/exam/#{exam_id}/completed"
    else
      redirect "/#{cat_level.name}/levels/exam/#{exam_id}/questions/#{quest_next}"
    end
  end

  def exam_finished(cat, exam_id)
    record = Record.find_by(user_id: session[:user_id])
    points_exam = RecordLevel.complete_levels(cat, session[:user_id])
    exam = Exam.find(exam_id)
    RecordExam.create(record_id: record.id, exam_id: exam.id, point: points_exam)
    Profile.update_points_profile(points_exam, session[:user_id])
  end
end
