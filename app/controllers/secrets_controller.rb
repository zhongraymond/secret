class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
    @user = User.find(session[:user_id])
    @secrets = Secret.all
    @secretsL = @user.secrets_liked
  end

  def create
        @secrets = Secret.new(content: params[:secret][:content].to_s, user_id:session[:user_id])
          if @secrets.save
            # binding.pry
            redirect_to :back
      else
        flash[:errors] = @secrets.errors.full_messages
        redirect_to :back
    end
  end

def destroy
  secret = Secret.find(params[:id])
  secret.destroy if secret.user == current_user
  redirect_to "/users/#{session[:user_id]}"
end

end
