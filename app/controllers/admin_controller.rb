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

<<<<<<< HEAD
  u=User.find_by_id(session[:user_id])

  u.username= params[:user][:username]
  u.email=params[:user][:email]
=======
  #u=User.find_by_id(session[:user_id]

  #u.username= params[:user][:username]
  #u.email=params[:user][:email]
>>>>>>> 41c4080cf0eec91f54f90a650f2f0ec856d77541
  #u.startwork= params[:user][:startwork]
  #u.endwork= params[:user][:endwork]
  #u.lunchstart= params[:user][:lunchstart]
  #u.lunchlength= params[:user][:lunchlength]
  #u.dailyemails=params[:user][:dailyemails]
<<<<<<< HEAD
  u.save

  flash[:success] = "Your details have been updated."

  redirect_to useradmin_path
=======
  #u.save

  #flash[:success] = "Your details have been updated."

  #redirect_to useradmin_path
>>>>>>> 41c4080cf0eec91f54f90a650f2f0ec856d77541

end

end
