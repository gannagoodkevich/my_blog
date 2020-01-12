class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery
  prepend_before_action :authenticate!

  helper_method :warden, :signed_in?, :current_user

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def not_existed_error
    render(file: "#{Rails.root}/public/404.html", layout: false)
  end

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end

class SessionsController < ApplicationController
  skip_before_action :authenticate!

  def create
    authenticate!
    redirect_to :root
  end

  def destroy
    warden.logout
    redirect_to :root
  end
end
=begin
class ConfirmationController < ApplicationController
  skip_before_action :authenticate!

  def show
    @user = UserAuth.where(:conf_token => params[:token]).first

    if @user.nil?
      flash.alert = t("confirmations.user.errors")
      redirect_to :root and return
    else
      flash.notice = t("confirmations.user.confirmed")
      @user.confirm!
      warden.set_user(@user)
      redirect_to user_auth_path(@user) and return
    end
  end

  protected

  def redirect_if_token_empty!
    unless params.has_key?(:token)
      flash.alert = t("confirmations.token.empty")
      redirect_to :root and return
    end
  end
end

class RegistrationsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @user = UserAuth.new(params[:user])
    if @user.save
      flash[:notice] = t("registrations.user.success")
      redirect_to :root
    end
  end
=end
