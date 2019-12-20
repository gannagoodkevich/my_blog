class PostsQuery
  attr_reader :relation

  def initialize(relation = Post.all)
    @relation = relation
  end

  def find_active_users_post(organization_id)
    with_users.where(users: {organization_id: organization_id, active: true})
  end

  def find_posts_by_name(name)
    User.find_by(name: name).posts
  end

  private

  def with_users
    @relation.joins(:user)
  end
end