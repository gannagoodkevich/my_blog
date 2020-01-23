class UsersController < ApplicationController
  before_action :find_organization
  before_action :find_user, only: %i[edit update show]

  def index
    @users = User.where(organization_id: params[:organization_id])
    return not_existed_error if @users.nil?

    @users = @users.page(params[:page])
  end

  def edit
    not_existed_error if @user.nil?
  end

  def create
    @organization = Organization.find(params.dig(:organization_id))
    @organization.users.create!(attr_user)
    UserMailer.with(organization: @organization, user: attr_user).new_user_mail.deliver_later
    redirect_to organization_users_path(@organization)
  end

  def update
    return not_existed_error if @user.nil?

    @user.update!(button_params)
    redirect_to organization_user_path
  end

  def show
    return not_existed_error if @user.nil?

    @posts = @user.posts.page(params[:page])
  end

  private

  def find_organization
    @organization = Organization.find_by(id: params[:organization_id])
    not_existed_error if @organization.nil?
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
