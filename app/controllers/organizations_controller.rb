class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page(params.dig(:page))
  end

  def update
    @organization.update(params.dig(:organization))
  end

  def show
    @organization = Organization.find(params.dig(:id))
  end
end
