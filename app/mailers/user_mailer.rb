class UserMailer < ApplicationMailer
  def new_user_mail
    email = Faker::Internet.email
    mail(to: email, subject: "New user was created")
  end
end
