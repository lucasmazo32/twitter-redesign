module JltHelper
  def foreign_view(user)
    if current_user == user
      render 'shared/self_opinion'
    else
      render 'shared/foreign_opinion'
    end
  end
end
