module UsersHelper
  def delete_user?(user)
    link_to 'Delete', me_path(user), method: :delete, data: { confirm: 'Really delete this user?' },
                                     class: 'btn btn-secundary'
  end

  def follow_or_stop(user)
    return if user == current_user
    if current_user.follows?(user)
      link_to  "Unfollow", me_path(@user, params: { follow: 'unfollow' }), method: :post, class:'btn btn-primary'
    else
      link_to  "Follow", me_path(@user, params: { follow: 'follow' }), method: :post,class:'btn btn-primary'
    end
  end
end
