class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit delete]
  before_action :not_logged, except: %i[new create]
  before_action :param_check, only: %i[index]

  def show
    @user = User.friendly.find(params[:id])
    @users = @user.opinions.includes([:author]).paginate(page: params[:page])
  end

  def index
    @user = User.find_by(username: params[:user])
    unless params[:q].nil?
      return @users = @user.search_param(params[:q]).includes([:opinions]).paginate(page: params[:page])
    end

    case params[:follow]
    when 'followers'
      @users = @user.followers.includes([:opinions]).paginate(page: params[:page])
    when 'following'
      @users = @user.following.includes([:opinions]).includes([:followds]).paginate(page: params[:page])
    when 'popular accounts'
      @users = @user.popular.includes([:opinions]).paginate(page: params[:page])
    when 'find friends'
      @users = current_user.find_friends.includes([:opinions]).paginate(page: params[:page])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user)
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
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    if @user
      @user.destroy
      flash[:danger] = 'User deleted'
    end
    log_out
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :photo, :coverimage)
  end

  def set_user
    @user = User.friendly.find(params[:id])
    redirect_to action: action_name, id: @user.friendly_id, status: 301 unless @user.friendly_id == params[:id]
  end

  def param_check
    redirect_to root_path if params[:user].nil?
  end
end
