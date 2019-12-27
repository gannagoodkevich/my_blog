class UserMailerPreview < ActionMailer::Preview
  def new_user_mail
    @organization = 'Hallo'
    @user_name = 'World'
    UserMailer.with(organization: @organization, user_name: @user_name).new_user_mail
  end
end