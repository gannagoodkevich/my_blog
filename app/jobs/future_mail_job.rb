class FutureMailJob < ApplicationJob

  def perform(*args)
    100.times do
      MailJob.perform_now
    end
  end
end
