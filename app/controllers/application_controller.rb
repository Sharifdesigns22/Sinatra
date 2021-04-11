require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    register Sinatra::ActiveRecordExtension
    enable :sessions
    set :session_secret, "my_application_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if session[:user_id] == nil
      erb :signup
    else
      redirect '/attendance'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :email=> params[:email], :password => params[:password])
    if user.username.empty? || user.email.empty? || !user.save
      flash[:notice] = "User creation unsuccessful, please try again."
      redirect '/signup'
    else user.save 
      session[:user_id] = user.id
      redirect '/attendance' 
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/attendance'
    else 
      erb :'/users/login'
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/attendance"
    else 
      flash[:notice] = "Login unsuccessful, please try again."
      redirect "/login"
    end
  end

  get '/logout' do
    if session[:user_id] == nil
      redirect "/"
    else
      session.clear
      redirect '/login'
    end
  end
end