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
    if @post.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && return
    end
  end

  def create
    if @user.nil?
      return not_existed_error
    end
    @user.posts.create!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def update
    if @post.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && return
    end

    @post.update!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    if @post.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && return
    end

    @post.destroy!
    redirect_to organization_posts_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
    if @organization.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && return
    end
  end

  def find_posts_by_status
    @post_status = @posts.active
    case params[:status]
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
    @user = User.find_by(id: post_params[:user_id])
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end

  def find_valid_users
    @users = []
    if params[:user_id].nil?
      @users = @organization.users.all
    else
      @users << User.find_by(id: params[:user_id])
    end
  end

  def post_params
    params.require(:post).permit(:content, :status, :user_id)
  end
end