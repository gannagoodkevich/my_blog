class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page params[:page]
  end

  def new
  end

  def update
    @organization.update(params[:organization])
  end

  def create
    render plain: params[:organization].inspect
  end

  def show
    @organization = Organization.find(params[:id])
  end
end
