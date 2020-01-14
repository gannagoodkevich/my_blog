Warden::Strategies.add(:password) do
  def valid?
    return false if request.get?
    user_data = params["user_auth"]
    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    user = UserAuth.find_by_email(params["user_auth"]["email"])
    if user.nil? || user.confirmed_at.nil? || user.password != params["user_auth"]["password"]
      fail! :message => "strategies.password.failed"
    else
      success! user
    end
  end
end