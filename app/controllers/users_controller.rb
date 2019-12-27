class UsersController < ApplicationController
  def index
    @users = User.where(organization_id: params.dig(:organization_id))
    @users = @users.page(params.dig(:page))
    @organization = Organization.find(params.dig(:organization_id))
  end

  def new
    @organization = Organization.find(params.dig(:organization_id))
  end


  def edit
    @user = User.find(params.dig(:id))
  end

  def create
    @organization = Organization.find(params.dig(:organization_id))
    @organization.users.create!(attr_user)
    UserMailer.with(organization: @organization, user: attr_user).new_user_mail.deliver_later
    redirect_to organization_users_path(@organization)
  end

  def update
    @organization = Organization.find(params.dig(:organization_id))
    User.find(params.dig(:id)).update!(attr_button)
    redirect_to organization_user_path
  end

  def show
    @user = User.find(params.dig(:id))
    @posts = @user.posts.page(params.dig(:page))
    @organization = Organization.find(params.dig(:organization_id))
  end

  private

  def attr_user
    params.require(:user).permit(:name, :active)
  end

  def attr_button
    params.require(:button).permit(:active)
  end
end
