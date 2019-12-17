class PostsController < ApplicationController
  def index
    @posts = Post.joins(:user).where(users: {organization_id: params[:organization_id], active: true})
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
    @post = Post.new(content: params[:post][:content], status: params[:post][:status], user_id: User.find_by(name: params[:post][:name]).id)
    @post.save!
    User.find_by(name: params[:post][:name]).posts << @post
    User.find_by(name: params[:post][:name]).save!
    redirect_to organization_posts_path(@organization)
  end

  def update
    @post = Post.find(params[:id])
    @user_prev = User.find(@post.user_id)
    @user = User.find_by(name: params[:post][:name])
    @user.posts << @post
    @user.save!
    @post.update!(content: params[:post][:content], status: params[:post][:status], user_id: @user.id)
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
