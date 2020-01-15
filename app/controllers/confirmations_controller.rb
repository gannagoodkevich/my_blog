class ConfirmationsController < ApplicationController
  skip_before_action :authenticate!
  before_action :redirect_if_token_empty!

  def show
    @user = User.where(:conf_token => params[:token]).first

    if @user.nil?
      flash.alert = t("confirmations.user.errors")
      redirect_to :root and return
    else
      flash.notice = t("confirmations.user.confirmed")
      @user.confirm!
      warden.set_user(@user)
      redirect_to :root
    end
  end

  protected

  def redirect_if_token_empty!
    unless params.has_key?(:token)
      flash.alert = t("confirmations.token.empty")
      redirect_to :root
    end
  end
end