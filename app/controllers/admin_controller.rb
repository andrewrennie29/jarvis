class AdminController < ApplicationController

def index

  if session[:user_id].nil?

    flash[:error] = "Please login."
    redirect '/'

  else

    @user=User.find_by_id(session[:user_id])
    render :index

  end

end

def updateuser

  u=User.find_by_id(session[:user_id]

  u.username= params[:user][:username]
  u.email=params[:user][:email]
  u.startwork= params[:user][:startwork]
  u.endwork= params[:user][:endwork]
  u.lunchstart= params[:user][:lunchstart]
  u.lunchlength= params[:user][:lunchlength]
  u.dailyemails=params[:user][:dailyemails]
  u.save

  flash[:success] = "Your details have been updated."

  redirect_to useradmin_path

end

end
