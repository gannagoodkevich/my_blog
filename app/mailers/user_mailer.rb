class UserMailer < ApplicationMailer
  def new_user_mail
    #@organization = params.dig(:organization)
    #@user = params.dig(:user)
    email = Faker::Internet.email
    mail(to: email, subject: "New user was created")
  end
  #Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '*/5 * * * *', class: 'HardWorker')
end
