class LikesController < ApplicationController
before_action :require_login, only: [:create, :destroy]
  def create
    # binding.pry
        likes = Like.new( user_id:session[:user_id], secret_id:params[:secret_id].to_i)
      if likes.save
        # binding.pry
          redirect_to "/secrets"
      else
        flash[:errors] = likes.errors.full_messages
          redirect_to "/secrets"
    end
  end

def destroy
  like = Secret.find(params[:id]).likes.where(user_id:session[:user_id])
  like.destroy_all
  redirect_to "/secrets"
end

end
