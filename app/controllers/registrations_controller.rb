class RegistrationsController < ApplicationController
  skip_before_action :authenticate!

  def show
    @user = UserAuth.new
  end

  def create
    @user = UserAuth.new(user_auth_params)
    puts user_auth_params[:email]
    @user.email = user_auth_params[:email]
    puts @user.inspect
    if @user.save
      flash[:notice] = t("registrations.user.success")
      redirect_to :root
    end
  end

  private

  def user_auth_params
    params.require(:user_auth).permit(:email, :password)
  end
end