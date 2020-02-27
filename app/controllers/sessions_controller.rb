class SessionsController < ApplicationController
  def new
    @users = User.first(15).sample(10)
  end

  def create
    user = User.find_by(username: params[:session][:username])
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
    log_out
    redirect_to login_path
  end
end
