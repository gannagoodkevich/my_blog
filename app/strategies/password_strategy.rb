class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?
    user_data = user_auth_params
    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    user = UserAuths.find_by_email(user_auth_params["email"])
    if user.nil? || user.confirmed_at.nil? || user.password != user_auth_params["password"]
      fail! :message => "strategies.password.failed"
    else
      success! user
    end
  end

  private

  def user_auth_params
    params.require(:user_auth).permit(:email, :password)
  end
end

Warden::Strategies.add(:password, PasswordStrategy)