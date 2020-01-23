class UserMailer < ApplicationMailer
  def new_user_mail
    @organization = params.dig(:organization)
    @user = params.dig(:user)
    mail(to: 'katsiaryna.sauchuk@itechart-group.com', subject: "New user was created")
  end
end
