class UserAuthsController < ApplicationController
  skip_before_action :authenticate!
end
