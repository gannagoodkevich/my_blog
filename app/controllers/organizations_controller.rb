class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page(org_params[:page])
  end

  def update
    @organization.update(org_params[:organization])
  end

  def show
    @organization = Organization.find_by(id: org_params[:id])
    if @organization.nil?
      render file: "#{Rails.root}/public/404.html", layout: false and return
    end
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  private

  def org_params
    params.permit(:page, :organization, :id, :locale)
  end
end
