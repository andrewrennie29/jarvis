class SessionsController < ApplicationController

def new

end

def create

@user = User.authenticate(params[:username], params[:password])

if @user

	flash[:notice] = "Login Successful!"

	session[:user_id] = @user.id

	redirect_to 'todos/index'

else

	flash[:alert] = 'You fail at logging in'

	redirect_to login_path

end

end

def destroy

session[:user_id] = nil

flash[:notice] = 'Logged out already? Guess you must have finished your work!'

redirect_to '/'

end

end
