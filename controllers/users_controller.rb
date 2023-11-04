class UsersController < Sinatra::Application
    set :views, File.expand_path('../views', __dir__)

    get '/' do
        erb :inicio # erb :index #mostrar index.erb
    end

    get '/registro' do
      erb :register
    end

    post '/formulario' do
      email = params[:email]
      username = params[:username]
      password = params[:password]
      password_confirmation = params[:password_repeat]
      if password == password_confirmation # Verificar que las contraseñas sean iguales
        @user = User.new(email: email, username: username, password: password) # Las contraseñas coinciden, crear la cuenta
        if @user.save
          profile = Profile.new(user_id: @user.id, totalPoints: 0)
          profile.save
          record = Record.new(user_id: @user.id)
          record.save
          ranking = Ranking.new(user_id: @user.id, points: 0)
          ranking.save
          redirect '/showLogin' # Redirigir a la página de inicio de sesión
        else
          erb :register
        end
      else
        @error = "passwords don't match" # Las contraseñas no coinciden, mostrar un mensaje de error
        erb :register
      end
    end
  
    post '/inicio' do
      erb :inicio
    end
  
    get '/showLogin' do
      erb :login
    end

    post '/login' do
      user = User.find_by(username: params[:username])
      passInput = params[:password]
      if user.nil?
        @errorUsername = 'Username no encontrado'
        redirect '/showLogin' # Redirige al usuario a la página de inicio de sesión
      elsif user.password == passInput
        @errorPassword = 'Contraseña incorrecta'
        session[:user_id] = user.id
        redirect '/lobby' # Redirige al usuario al lobby si las contraseñas coinciden
      else
        erb :login
      end
    end
  
    post '/logout' do
      session.clear
      redirect '/'
    end
end