class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit delete]
  before_action :not_logged

  def show
    @user = User.friendly.find(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to me_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to me_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    @user.destroy
    flash[:success] = 'User deleted succesfully'
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :photo, :coverimage)
  end

  def set_user
    @user = User.friendly.find(params[:id])
    redirect_to action: action_name, id: @user.friendly_id, status: 301 unless @user.friendly_id == params[:id]
  end
end
