class SendMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'send_present'

  def perform(*args)
    10000.times do
      MailJob.perform_now
    end
  end
end
