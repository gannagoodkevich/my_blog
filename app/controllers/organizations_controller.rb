class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page(org_params[:page])
  end

  def update
    @organization.update(org_params[:organization])
  end

  def show
    @organization = Organization.find(org_params[:id])
  end

  private

  def org_params
    params.permit(:page, :organization, :id, :locale)
  end
end
