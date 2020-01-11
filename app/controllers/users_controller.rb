class UsersController < ApplicationController
  before_action :find_organization
  before_action :find_user, only: %i[edit update show]

  def index
    @users = User.where(organization_id: params[:organization_id])
    if @users.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
    @users = @users.page(params[:page])
  end

  def edit
    if @user.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
  end

  def create
    @organization.users.create!(user_params)
    redirect_to organization_users_path(@organization)
  end

  def update
    if @user.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
    @user.update!(button_params)
    redirect_to organization_user_path
  end

  def show
    if @user.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
    @posts = @user.posts.page(params.dig(:page))
  end

  private

  def find_organization
    @organization = Organization.find_by(id: params[:organization_id])
    if @organization.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false) && (return)
    end
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :active)
  end

  def button_params
    params.require(:button).permit(:active)
  end
end
