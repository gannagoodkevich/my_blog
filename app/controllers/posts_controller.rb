class PostsController < ApplicationController
  before_action :find_organization
  before_action :find_user, only: [:create]
  before_action :find_post, only: %i[update destroy edit]

  def index
    @posts = Post.with_active_users(params[:organization_id])
    @posts = @posts.page(params[:page])
    find_posts_by_status
  end

  def new
    @post = Post.new
    find_valid_users
  end

  def edit
    return not_existed_error if @post.nil?

  end

  def create
    return not_existed_error if @user.nil?

    @user.posts.create!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def update
    return not_existed_error if @post.nil?

    @post.update!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    return not_existed_error if @post.nil?

    @post.destroy!
    redirect_to organization_posts_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
    return not_existed_error if @organization.nil?

  end

  def find_posts_by_status
    @post_status = @posts.active
    case params[:post_status]
    when 'active'
      @post_status = @posts.active
    when 'inactive'
      @post_status = @posts.inactive
    when 'under_review'
      @post_status = @posts.under_review
    when 'archived'
      @post_status = @posts.archived
    end
  end

  def find_user
    @user = User.find_by(id: user_params[:user_id])
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end

  def find_valid_users
    @users = []
    if params[:user_id].present?
      @users << User.find_by(id: params[:user_id])
    else
      @users = @organization.users.all
    end
  end

  def post_params
    params.require(:post).permit(:content, :status, :user_id)
  end

  def user_params
    params.require(:post).permit(:user_id)
  end
end