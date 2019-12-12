class PostsController < ApplicationController
  def index
    #@posts = User.includes(:posts).where(organization_id: params[:organization_id])
    @posts = Post.joins(:user).where(users: {organization_id: params[:organization_id], active: true})
    @posts = @posts.page params[:page]
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
    render plain: params.inspect
  end

  def create
    @organization = Organization.find(params[:organization_id])
    name = params[:post][:name]
    @post = Post.new(post_attr)
    User.find_by(name: name).posts << @post
    redirect_to organization_posts_path(@organization)
  end

  def update
    @post = Post.find(params[:id])
    #render plain: @post.inspect
    #@post.update!(post_attr)
    render plain: params.inspect
    @post.update!(content: params[:post][:content], status: params[:post][:status])
    #redirect_to organization_posts_path(@organization)
  end

  private

  def post_attr
    params.require(:post).permit(:content, :status)
  end
end
