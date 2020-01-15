Warden::Strategies.add(:password) do
  def valid?
    return false if request.get?
    params = request.params
    !(params["email"].blank? || params["password"].blank?)
  end

  def authenticate!
    user = User.find_by_email(params["email"])
    if user.nil? || user.confirmed_at.nil? || user.password != params["password"]
      fail! :message => "strategies.password.failed"
    else
      success! user
    end
  end
end