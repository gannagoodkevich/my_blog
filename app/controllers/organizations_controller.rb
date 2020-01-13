class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all.page(params[:page])
  end

  def update
    @organization.update(org_params[:organization])
  end

  def show
    @organization = Organization.find_by(id: org_params[:id])
    if @organization.nil?
      return not_existed_error
    end
  end

  private

  def org_params
    params.permit(:page, :organization, :id, :locale)
  end
end
