class UsersController < ApplicationController

def new

end

def create

	@user = User.new(user_params)
	if @user.save
		flash[:notice] = "Sign up successful"
		redirect_to 'todos/index'
	else
		flash[:alert] = "#fail! Please try again."
		redirect_to :back
	end
	
end

def user_params

	params.require(:user).permit(:username, :email, :password, :confirm_password)

end

end