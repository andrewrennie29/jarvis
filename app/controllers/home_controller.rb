class HomeController < ApplicationController

def index

if session[:user_id].nil?


render :index

else

redirect_to index_path

end

end

end
