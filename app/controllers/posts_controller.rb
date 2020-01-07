class PostsController < ApplicationController
  before_action :find_organization
  before_action :find_user

  def index
    @posts = Post.with_active_users(organization_attr)
    @posts = @posts.page(params.dig(:page))
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
    @default_name = @organization.users.first
    @default_status = Post.statuses.first
    @users = []
    if request.referrer.split('/')[-2] == 'users'
      @user_id = request.referrer.split('/')[-1]
      @users << User.find(@user_id)
    else
      @users = @organization.users.all
    end
  end

  def edit
    @post = Post.find(params.dig(:id))
  end

  def create
    raise 'User not find error' if @user.nil?

    @user.posts.create!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def update
    Post.find_by(id: params.dig(:id)).update!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    @post = Post.find(params.dig(:id))
    @post.destroy!

    redirect_to organization_posts_path(@organization)
  end

  private

  def post_attr
    params.require(:post).permit(:content, :status, :user_id)
  end

  def organization_attr
    params.dig(:organization_id)
  end

  def find_organization
    @organization = Organization.find(organization_attr)
  end

  def find_user
    @user = User.find_by(id: params.dig(:post, :user_id))
  end
end
