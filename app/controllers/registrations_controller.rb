class RegistrationsController < ApplicationController
  before_action :find_organization
  skip_before_action :authenticate!

  def show
    @user = User.new
  end

  def create
    @organization.users.create!(user_auth_params)
    flash[:notice] = t("registrations.user.success")
    redirect_to :root
  end

  private

  def user_auth_params
    params.require(:user).permit(:email, :password, :name)
  end

  def find_organization
    @organization = Organization.find_by(id: params[:organization_id])
    if @organization.nil?
      render(file: "#{Rails.root}/public/404.html", layout: false)
    end
  end
end