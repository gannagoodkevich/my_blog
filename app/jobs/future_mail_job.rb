class FutureMailJob < ApplicationJob

  def perform(*args)
    100.times do
      MailJob.perform_later
    end
  end
end
