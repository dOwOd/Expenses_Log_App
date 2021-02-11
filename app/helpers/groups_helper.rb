module GroupsHelper
  def join_group(group)
    session[:group_id] = group.friendly_url
  end
end
