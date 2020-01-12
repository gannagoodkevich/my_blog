class RegistrationsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @user = UserAuth.new(params[:user])
    if @user.save
      flash[:notice] = t("registrations.user.success")
      redirect_to :root
    end
  end
end