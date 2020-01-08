class PostsController < ApplicationController
  before_action :find_organization
  #before_action :find_user

  def index
    @posts = Post.with_active_users(common_attr[:organization_id])
    @posts = @posts.page(page_attr[:page])
    @post_status = @posts.active
    @post_status = @posts.active if status_attr[:active]
    @post_status = @posts.inactive if status_attr[:inactive]
    @post_status = @posts.under_review if status_attr[:under_review]
    @post_status = @posts.archived if status_attr[:archived]
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
    @post = Post.find_by(id: params[:id])
  end

  def create
    find_user
    raise 'User not find error' if @user.nil?

    @user.posts.create!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def update
    Post.find_by(id: post_attr[:user_id]).update!(post_attr)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    @post = Post.find(common_attr[:id])
    puts @post.inspect
    @post.delete

    redirect_to organization_posts_path(@organization)
  end

  private

  def post_attr
    params.require(:post).permit(:content, :status, :user_id)
  end

  def common_attr
    params.permit(:organization_id, :locale, :id)
  end

  def find_organization
    @organization = Organization.find(status_attr[:organization_id])
  end

  def find_user
    @user = User.find_by(id: params.permit(:organization_id, :user_id, :locale, :id))
  end

  def status_attr
    params.permit(:active, :inactive, :under_review, :archived, :locale, :organization_id)
  end

  def page_attr
    params.permit(:page)
  end
end