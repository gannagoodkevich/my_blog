class SessionsController < ApplicationController
  skip_before_action :authenticate!

  def create
    warden.authenticate!
    redirect_to :root
  end

  def destroy
    warden.logout
    redirect_to :root
  end
end
