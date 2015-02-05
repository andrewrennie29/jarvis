class UsersController < ApplicationController

def new

end

def create

	@user = User.new(user_params)
	if @user.save
		flash[:notice] = "Sign up successful"

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

end