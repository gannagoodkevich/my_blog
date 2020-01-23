class OrganizationsController < ApplicationController
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

  private

  def org_update_params
    params.permit(:organization)
  end
end
