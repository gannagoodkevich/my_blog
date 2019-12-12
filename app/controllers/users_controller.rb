class UsersController < ApplicationController
  def index
    #@posts = User.includes(:posts).where(organization_id: params[:organization_id])
    @users = User.where(organization_id: params[:organization_id])
    @users = @users.page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page params[:page]
  end
end
