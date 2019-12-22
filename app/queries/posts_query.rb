class PostsQuery
  def find_posts_with_status(params, posts)
    post_status = posts.active
    post_status = posts.active if params[:active]
    post_status = posts.inactive if params[:inactive]
    post_status = posts.under_review if params[:under_review]
    post_status = posts.archived if params[:archived]
    post_status
  end

  def find_default_name(organization_id)
    find_organization(organization_id).users.first
  end

  def find_organization(organization_id)
    Organization.find(organization_id)
  end
end
