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
    request.env["warden"]
  end

  def authenticate!
    warden.authenticate!
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
