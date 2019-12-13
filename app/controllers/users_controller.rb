class UsersController < ApplicationController
  def index
    #@posts = User.includes(:posts).where(organization_id: params[:organization_id])
    @users = User.where(organization_id: params[:organization_id])
    @users = @users.page params[:page]
  end

  def new

  end


  def create
    @organization = Organization.find(params[:organization_id])
    @user = User.new(name: params[:user][:name], active: params[:user][:status], organization_id: params[:organization_id])
    @user.save!
    #User.find_by(name: params[:post][:name]).posts << @post
    #User.find_by(name: params[:post][:name]).save!
    redirect_to organization_users_path(@organization)
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @user = User.find(params[:id])
    @user.update!(active: params[:button][:active])
    #User.find_by(name: params[:post][:name]).posts << @post
    #User.find_by(name: params[:post][:name]).save!
    redirect_to organization_users_path(@organization)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page params[:page]
  end
end
