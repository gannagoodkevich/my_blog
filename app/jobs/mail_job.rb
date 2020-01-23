class MailJob < ApplicationJob
  queue_as :mailer


  def perform(*args)
    UserMailer.with(organization: "Hello", user: "World").new_user_mail.deliver_now
  end
end
