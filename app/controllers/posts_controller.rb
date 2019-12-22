class PostsController < ApplicationController
  def index
    @posts = Post.with_active_users(params.dig(:organization_id))
    @posts = @posts.page(params.dig(:page))
    @organization = PostsQuery.new.find_organization(params.dig(:organization_id))
    @post_status = PostsQuery.new.find_posts_with_status(params, @posts)
  end

  def new
    @post = Post.new
    @default_name = PostsQuery.new.find_default_name(params.dig(:organization_id))
    @default_status = Post.statuses.first
    @organization = PostsQuery.new.find_organization(params.dig(:organization_id))
  end

  def edit
    @post = Post.find(params.dig(:id))
    @organization = PostsQuery.new.find_organization(params.dig(:organization_id))
  end

  def create
    @organization = PostsQuery.new.find_organization(params.dig(:organization_id))
    User.find(params.dig(:post, :user_id)).posts.create!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def update
    Post.find_by(id: params.dig(:id)).update!(post_attr)
    @organization = PostsQuery.new.find_organization(params.dig(:organization_id))
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    @post = Post.find(params.dig(:id))
    @post.destroy!

    @organization = PostsQuery.new.find_organization(params.dig(:organization_id))
    redirect_to organization_posts_path(@organization)
  end

  private

  def post_attr
    params.require(:post).permit(:content, :status, :user_id)
  end
end
