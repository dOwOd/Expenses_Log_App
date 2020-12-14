module GroupsHelper
  def join_group(group)
    session[:group_id] = group.id
  end
end
