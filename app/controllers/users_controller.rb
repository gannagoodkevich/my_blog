class UsersController < ApplicationController
  before_action :find_organization

  def index
    @users = User.where(organization_id: common_params[:organization_id])
    @users = @users.page(common_params[:page])
  end

  def new
  end

  def edit
    @user = User.find(common_params[:id])
  end

  def create
    @organization.users.create!(user_params)
    redirect_to organization_users_path(@organization)
  end

  def update
    User.find(common_params[:id]).update!(button_params)
    redirect_to organization_user_path
  end

  def show
    @user = User.find(common_params[:id])
    @posts = @user.posts.page(params.dig(:page))
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end

  def user_params
    params.require(:user).permit(:name, :active)
  end

  def button_params
    params.require(:button).permit(:active)
  end

  def common_params
    params.permit(:id, :organization_id, :locale, :page)
  end
end
