class OrganizationsController < ApplicationController
  skip_before_action :authenticate!

  def index
    @organizations = Organization.all.page(params[:page])
  end

  def update
    @organization.update(org_update_params)
  end

  def show
    @organization = Organization.find_by(id: params[:id])
    return not_existed_error if @organization.nil?

  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  private

  def org_update_params
    params.permit(:organization)
  end
end
