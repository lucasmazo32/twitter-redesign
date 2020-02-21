module UsersHelper
  def delete_user?(user)
    link_to 'Delete', me_path(user), method: :delete, data: { confirm: 'Really delete this user?' },
                                     class: 'btn btn-secundary'
  end
end
