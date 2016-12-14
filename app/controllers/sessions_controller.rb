class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(user_params[:email])
    # binding.pry
      if user && user.authenticate(user_params[:password])
        session[:user_id] = user.id
        # binding.pry
        redirect_to "/users/#{user.id}"
  else
    flash[:errors]= ["Invalid combination"]
    redirect_to "/users/new"
    end
  end

  def destroy
    reset_session
    redirect_to "/sessions/new"
  end
  
private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
