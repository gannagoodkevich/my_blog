class UsersController < ApplicationController
  before_action :find_organization, :permit_params

  def index
    @users = User.where(organization_id: params[:organization_id])
    @users = @users.page(params.dig(:page))
  end

  def new
  end

  def edit
    @user = User.find(params.dig(:id))
  end

  def create
    @organization.users.create!(user_params)
    redirect_to organization_users_path(@organization)
  end

  def update
    User.find(params.dig(:id)).update!(button_params)
    redirect_to organization_user_path
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params.dig(:page))
  end

  private

  def user_params
    params.require(:user).permit(:name, :active)
  end

  def button_params
    params.require(:button).permit(:active)
  end

  def permit_params
    params.permit(:id, :organization_id, :locale)
  end

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end
end
