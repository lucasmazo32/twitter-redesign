class SessionsController < ApplicationController
  def new
    @users = User.first(15).sample(10)
  end

  def create
    user = User.find_by(login_params)
    if user
      log_in user
      redirect_to root_path
    else
      @users = User.first(15).sample(10)
      flash.now[:danger] = 'The user does not exist'
      render 'new'
    end
  end

  def destroy
    if session[:user_id]
      log_out
    elsif current_user
      @current_user = nil
    end
    redirect_to login_path
  end

  private

  def login_params
    params.require(:session).permit(:username)
  end
end
