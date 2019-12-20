class PostsController < ApplicationController
  def index
    @posts = Post.with_active_users(params[:organization_id])
    @posts = @posts.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    User.find(params[:post][:user_id]).posts.create!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def update
    Post.find_by(id: params[:id]).update!(post_attr)
    @organization = Organization.find(params[:organization_id])
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!

    @organization = Organization.find(params[:organization_id])
    redirect_to organization_posts_path(@organization)
  end

  private

  def post_attr
    params.require(:post).permit(:content, :status, :user_id)
  end
end
