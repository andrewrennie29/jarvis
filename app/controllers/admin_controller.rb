def AdminController 

def index

  if session[:user_id].nil?

    flash[:error] = "Please login."
    redirect '/'

  else

    @user=User.find_by_id(sessions[:user_id])
    redner :index

  end

end

end
