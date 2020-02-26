class JltController < ApplicationController
  before_action :not_logged
  
  def index
    @jlt = current_user.network_tweets.paginate(page: params[:page])
  end

  def show
    @opinion = Opinion.includes(:author).find(params[:id])
  end

  def create
    opinion = current_user.opinions.build(opinion_params)
    if opinion.save
      redirect_to root_path
    else
      flash.now[:danger] = 'The post could not be created'
      render 'index'
    end
  end

  def foreign
    opinion = current_user.opinions.build(opinion_params)
    if opinion.save
      flash[:success] = 'Your JLT was created successfully!'
      redirect_back fallback_location: '/'
    else
      flash[:danger] = 'The JLT could not be created (too long)'
      redirect_back fallback_location: '/'
    end
  end

  def followers
    user = User.friendly.find(params[:id])
    if params[:follow] == 'follow'
      follower = current_user.follows.build(followed: user)
      follower.save
      flash[:success] = 'Now following'
    else
      follower = current_user.follows?(user)
      follower.delete
      flash[:success] = 'Stopped following'
    end
    redirect_back fallback_location: '/'
  end

  private

  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
