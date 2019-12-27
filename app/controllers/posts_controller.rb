class PostsController < ApplicationController
  def index
    @posts = Post.with_active_users(organization_attr)
    @posts = @posts.page(params.dig(:page))
    @organization = Organization.find(organization_attr)
    @post_status = @posts.active
    if params[:active]
      @post_status = @posts.active
    end
    if params[:inactive]
      @post_status = @posts.inactive
    end
    if params[:under_review]
      @post_status = @posts.under_review
    end
    if params[:archived]
      @post_status = @posts.archived
    end
  end

  def new
    @post = Post.new
    @default_name = Organization.find(organization_attr).users.first
    @default_status = Post.statuses.first
    @organization = Organization.find(organization_attr)
  end

  def edit
    @post = Post.find(params.dig(:id))
    @organization = Organization.find(organization_attr)
  end

  def create
    @organization = Organization.find(organization_attr)
    User.find_by(id: params.dig(:post, :user_id)).posts.create!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def update
    Post.find_by(id: params.dig(:id)).update!(post_attr)
    @organization = Organization.find(organization_attr)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    @post = Post.find(params.dig(:id))
    @post.destroy!

    @organization = Organization.find(organization_attr)
    redirect_to organization_posts_path(@organization)
  end

  private

  def post_attr
    params.require(:post).permit(:content, :status, :user_id)
  end

  def organization_attr
    params.dig(:organization_id)
  end
end
