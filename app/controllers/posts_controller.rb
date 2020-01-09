class PostsController < ApplicationController
  before_action :find_organization

  def index
    @posts = Post.with_active_users(status_params[:organization_id])
    @posts = @posts.page(status_params[:page])
    find_posts_by_status
  end

  def new
    @post = Post.new
    @default_name = @organization.users.first
    @default_status = Post.statuses.first
    @users = find_valid_users
  end

  def edit
    @post = Post.find_by(id: common_params[:id])
  end

  def create
    @user = find_user
    raise 'User not find error' if @user.nil?

    @user.posts.create!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def update
    Post.find_by(id: common_params[:id]).update!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    @post = Post.find(common_params[:id])
    @post.destroy!

    redirect_to organization_posts_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(status_params[:organization_id])
  end

  def find_posts_by_status
    @post_status = @posts.active
    @post_status = @posts.active if status_params[:active]
    @post_status = @posts.inactive if status_params[:inactive]
    @post_status = @posts.under_review if status_params[:under_review]
    @post_status = @posts.archived if status_params[:archived]
  end

  def find_user
    User.find_by(id: post_params[:user_id])
  end

  def find_valid_users
    users = []
    if request.referrer.split('/')[-2] == 'users'
      user_id = request.referrer.split('/')[-1]
      users << User.find(user_id)
    else
      users = @organization.users.all
    end
    users
  end

  def post_params
    params.require(:post).permit(:content, :status, :user_id)
  end

  def common_params
    params.permit(:organization_id, :locale, :id, :page)
  end

  def status_params
    params.permit(:active, :inactive, :under_review, :archived, :locale, :organization_id, :id, :page)
  end
end