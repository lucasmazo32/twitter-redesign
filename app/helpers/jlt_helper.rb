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

  def main_options_jlt(user)
    if user
      link_to me_path(@user) do
        tag.span "JLT's"
      end
    else
      link_to '/' do
        tag.span "JLT's"
      end
    end
  end
end
