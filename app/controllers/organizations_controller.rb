class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page(params[:page])
  end

  def update
    @organization.update(org_update_params)
  end

  def show
    @organization = Organization.find_by(id: org_params)
    return not_existed_error if @organization.nil?

  end

  private

  def org_update_params
    params.permit(:organization)
  end

  def org_params
    params.permit(:id)
  end
end
