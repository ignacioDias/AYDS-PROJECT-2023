# routes/post_routes.rb
class MyAppPost < Sinatra::Base
  include App::MyHelpers
  helpers MyHelpers

  post '/inicio' do
    erb :inicio
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
          erb :game_completed # No hay más preguntas, mostrar mensaje de juego completado
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
end