class UsersController < ApplicationController

def show

render :admin

end

def new

end

def create

	@user = User.new(user_params)
	if @user.save
		flash[:notice] = "Sign up successful"
		
		#UserMailer.welcome_email(@user).deliver

		session[:user_id] = @user.id

		redirect_to index_path

	else
		flash[:alert] = "#fail! Please try again."
		redirect_to :back
	end
	
end

def user_params

	params.require(:user).permit(:username, :email, :password, :confirm_password)

end

def admin

if session[:user_id].nil?

      redirect_to '/'

    else

      @user=User.find_by_id(session[user_id])
      render :admin

    end

end

def update

  @user = User.find_by_id(session[:user_id])

end

end
