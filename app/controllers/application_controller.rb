class ApplicationController < ActionController::Base
  before_action :set_locale

  def not_existed_error
    render(file: "#{Rails.root}/public/404.html", layout: false)
  end

  def after_sign_in_path_for(resource)
    user_auths_welcome_path
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
