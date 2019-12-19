class PostsController < ApplicationController
  def index
    @posts = Post.with_active_users(params[:organization_id])
    @posts = @posts.page params[:page]
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    User.find(params[:post][:id]).posts.create!(content: params[:post][:content], status: params[:post][:status])
    redirect_to organization_posts_path(@organization)
  end

  def update
    @post = Post.find(params[:id])
    @post.update!(content: params[:post][:content], status: params[:post][:status], user_id: params[:post][:id])
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
    params.require(:post).permit(:content, :status)
  end
end
