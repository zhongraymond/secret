class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all

  end

  def create
        @user = User.new(user_params)
          if @user.save
            session[:user_id] = @user.id
            # binding.pry
            redirect_to "/users/#{@user.id}"
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to users_new_path
    end
  end

  def new
    @user = User.new
  end

def show
  @user = User.find(params[:id])
  @secrets =  @user.secrets
  @secretsL = @user.secrets_liked
  # binding.pry
end

def destroy
  reset_session
  @user = User.find(params[:id]).destroy
  redirect_to '/sessions/new'
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)

    redirect_to controller: 'users', action:'show', id:params[:id]
  else
    flash[:errors] = @user.errors.full_messages
    redirect_to "/users/#{@user.id}/edit"
  end
end

private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
