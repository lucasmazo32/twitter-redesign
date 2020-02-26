module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged?
    !current_user.nil?
  end

  def not_logged
    redirect_to login_path unless logged?
  end

  def correct_user
    current_user == User.friendly.find(params[:id])
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
  end

  def current_view
    if current_user
      link_to @current_user.name.to_s, me_path(@current_user), class: 'btn btn-secundary'
    else
      link_to 'Sign in', login_path, class: 'btn btn-secundary'
    end
  end
end
