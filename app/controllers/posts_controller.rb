class PostsController < ApplicationController
  before_action :find_organization
  before_action :find_user, only: [:create]
  before_action :find_post, only: [:update, :destroy, :edit]

  def index
    @posts = Post.with_active_users(status_params[:organization_id])
    @posts = @posts.page(status_params[:page])
    find_posts_by_status
  end

  def new
    @post = Post.new
    @default_name = @organization.users.first
    @default_status = Post.statuses.first
    find_valid_users
  end

  def edit
    if @post.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
  end

  def create
    if @user.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
    @user.posts.create!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def update
    if @post.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end

    @post.update!(post_params)
    redirect_to organization_posts_path(@organization)
  end

  def destroy
    if @post.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end

    @post.destroy!
    redirect_to organization_posts_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(status_params[:organization_id])
    if @organization.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
  end

  def find_posts_by_status
    @post_status = @posts.active
    @post_status = @posts.active if status_params[:active]
    @post_status = @posts.inactive if status_params[:inactive]
    @post_status = @posts.under_review if status_params[:under_review]
    @post_status = @posts.archived if status_params[:archived]
  end

  def find_user
    @user = User.find_by(id: post_params[:user_id])
  end

  def find_post
    @post = Post.find_by(id: common_params[:id])
  end

  def find_valid_users
    @users = []
    if request.referrer.split("/")[-2] == "users"
      @users << User.find_by(id: request.referrer.split("/").last)
    else
      @users = @organization.users.all
    end
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