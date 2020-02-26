module JltHelper
  def foreign_view(user)
    if current_user == user
      render 'shared/self_opinion'
    else
      render 'shared/foreign_opinion'
    end
  end

  def whotoprofile(user)
    if current_user == user
      render 'users/who_self'
    else
      render 'users/who_foreign'
    end
  end
end
