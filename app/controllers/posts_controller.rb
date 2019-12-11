class PostsController < ApplicationController
  def index
    #@posts = User.includes(:posts).where(organization_id: params[:organization_id])
    @posts = Post.joins(:user).where(users: {organization_id: params[:organization_id], active: true})
    @posts = @posts.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end
end
