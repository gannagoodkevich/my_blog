class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page params[:page]
  end

  def show
    @organization = Organization.find(params[:id])
  end
end
