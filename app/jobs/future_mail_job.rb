class FutureMailJob < ApplicationJob
  queue_as :send_future

  def perform(*args)
    # Do something later
    10.times do
      MailJob.perform_now
    end
  end
end
