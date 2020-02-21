class JltController < ApplicationController
  def index
    @opinions = Opinion.includes(:author).order(created_at: :desc)
  end

  def show
    @opinion = Opinion.includes(:author).find(params[:id])
  end
end
