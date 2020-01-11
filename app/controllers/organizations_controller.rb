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

  private

  def org_params
    params.permit(:page, :organization, :id, :locale)
  end
end
